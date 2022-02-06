defmodule HackerNewsCoreTest do
  use ExUnit.Case

  # test_persistant_50_news_updated

  test "test_persistant_50_news_updated" do
    HackerNewsCore.fetch_top_news()
    assert Enum.count(HackerNewsCore.Top50Agent.value) == 50
  end

  # test_fetching_top_50_in_cache

  # test_fetching_news_by_id_in_cache

  test "test_fetching_news_by_id_in_cache" do
    news_id = HackerNewsCore.fetch_top_news() |> List.first()
    news_from_cache =  HackerNewsCore.find_news(news_id)
    assert news_id == news_from_cache[:id]
  end
end
