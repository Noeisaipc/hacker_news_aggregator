defmodule HackerNewsCore do
  @moduledoc """
  Documentation for `HackerNewsCore`.
  """
  alias HackerNewsCore.Monitor

  @spec fetch_top_news :: :ok
  def fetch_top_news() do
    HackerNewsApi.fetch_news_data()
    |> Enum.map(fn story ->
      HackerNewsCore.Monitor.insert_news(story)
    end)
  end

  def find_news(id) do
    HackerNewsCore.Monitor.find_news(id)
  end
end
