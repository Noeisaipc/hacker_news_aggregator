use Mix.Config

hacker_news_api_url = "https://hacker-news.firebaseio.com/v0"

config :hacker_news_api, HackerNewsApi.Config,
  top_news: hacker_news_api_url <> "/topstories.json",
  news_info: hacker_news_api_url <> "/item/ID.json"

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hacker_news_web, HackerNewsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
