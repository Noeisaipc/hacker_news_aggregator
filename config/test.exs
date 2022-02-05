use Mix.Config

hacker_news_api_url = "https://hacker-news.firebaseio.com/v0"

config :hacker_news_api, HackerNewsApi.Config,
  top_news: hacker_news_api_url <> "/topstories.json",
  news_info: hacker_news_api_url <> "/item/ID.json"
