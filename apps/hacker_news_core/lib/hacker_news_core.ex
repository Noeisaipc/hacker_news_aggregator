defmodule HackerNewsCore do
  @moduledoc """
  Documentation for `HackerNewsCore`.
  """
  alias HackerNewsCore.{Monitor, Top50Agent}

  @spec retrive_top_50 :: list
  def retrive_top_50() do
    Top50Agent.value()
    |> Enum.map(fn id_story -> Monitor.find_news(id_story) end)
  end

  @spec fetch_top_news :: :ok
  def fetch_top_news() do
    news =
      HackerNewsApi.fetch_news_data()
      |> Enum.map(fn story ->
        Monitor.insert_news(story)
      end)

    save_top_50(news)
    news
  end

  @spec save_top_50(list) :: :ok
  def save_top_50(news) do
    Top50Agent.update(news)
  end

  def find_news(id) do
    Monitor.find_news(id)
  end
end
