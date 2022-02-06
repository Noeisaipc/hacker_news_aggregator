defmodule HackerNewsCore do
  @moduledoc """
  Documentation for `HackerNewsCore`.
  """
  alias HackerNewsCore.{Monitor, Top50Agent}

  @spec fetch_top_news :: :ok
  def fetch_top_news() do
    news = HackerNewsApi.fetch_news_data()
    |> Enum.map(fn story ->
      Monitor.insert_news(story)
    end)
    persistant_top_50(news)
    news
  end

  @spec persistant_top_50(list) :: :ok
  def persistant_top_50(news) do
    Top50Agent.update(news)
  end

  def find_news(id) do
    HackerNewsCore.Monitor.find_news(id)
  end
end
