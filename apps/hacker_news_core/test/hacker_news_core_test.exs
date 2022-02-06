defmodule HackerNewsCoreTest do
  use ExUnit.Case
  alias HackerNewsCore.Top50Agent

  # test_persistant_50_news_updated

  test "test_persistant_50_news_updated" do
    assert Enum.count(Top50Agent.value()) == 50
  end

  # test_fetching_top_50_in_cache

  test "test_fetching_top_50_in_cache" do
    assert Enum.count(HackerNewsCore.retrive_top_50()) == 50
  end

  # test_fetching_news_by_id_in_cache

  test "test_fetching_news_by_id_in_cache" do
    news_id = Top50Agent.value() |> List.first()
    news_from_cache = HackerNewsCore.find_news(news_id)
    assert news_id == Integer.to_string(news_from_cache[:id])
  end
end
