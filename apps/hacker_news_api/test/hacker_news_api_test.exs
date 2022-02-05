defmodule HackerNewsApiTest do
  use ExUnit.Case
  @limit_of_top_news 50

  test "fetch_top_50_news" do
    news_top_50 = HackerNewsApi.fetch_news_data()
    assert Enum.count(news_top_50) == @limit_of_top_news
  end

  test "sorter_order_top_50_news" do
    news_top_50 = HackerNewsApi.fetch_news_data()
    assert Enum.sort(news_top_50, :desc) == news_top_50
  end

  test "fecth_news_by_id" do
    fecth_news_by_id = HackerNewsApi.Item.fetch("1")
    assert fecth_news_by_id != nil
  end

  test "fecth_inexistend_news_by_id" do
    fecth_news_by_id = HackerNewsApi.Item.fetch("0")
    assert fecth_news_by_id == %{}
  end
end
