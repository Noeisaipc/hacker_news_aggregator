defmodule HackerNewsApi do
  @moduledoc """
  Documentation for `HackerNewsApi`.
  """
  @limit_of_top_news 50

  alias HackerNewsApi.{TopNews, Item}
  @spec fetch_news_data() :: list()
  def fetch_news_data() do
    TopNews.get_top_news()
    |> Enum.sort(:desc)
    |> get_news_metadata()
  end

  @spec get_news_metadata(list) :: list
  def get_news_metadata(list_ids) do
    list_ids
    |> Stream.chunk_every(10)
    |> Enum.reduce_while({0, []}, fn stream, acc -> fetch_news_metadata(stream, acc) end)
    |> send_news()
  end

  @spec fetch_news_metadata(Stream.t(), {Integer.t(), list()}) ::
          {:cont, {Integer.t(), list}} | {:halt, list}
  def fetch_news_metadata(_stream, {num_stories, stories}) when num_stories >= @limit_of_top_news,
    do: {:halt, Enum.take(stories, @limit_of_top_news)}

  def fetch_news_metadata(stream, {_num_stories, stories}) do
    next_stories =
      Enum.map(stream, fn id_item -> Task.async(fn -> Item.fetch(id_item) end) end)
      |> Enum.map(&Task.await(&1))
      |> Enum.filter(fn item -> item[:type] == "story" end)

    total_stories = stories ++ next_stories
    new_number_stories = Enum.count(total_stories)
    {:cont, {new_number_stories, total_stories}}
  end

  @spec send_news(list() | {Integer.t(), list()}) :: list()
  def send_news({_num_stories, stories}),
    do: Enum.map(stories, fn story -> {story[:id], story} end)

  def send_news(stories) when is_list(stories),
    do: Enum.map(stories, fn story -> {story[:id], story} end)
end
