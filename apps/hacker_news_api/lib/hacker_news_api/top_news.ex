defmodule HackerNewsApi.TopNews do
  @moduledoc """
  Module for creating the required structure for spei transfer
  """
  use HackerNewsApi.Responder
  require Logger

  @spec get_top_news() :: map()
  def get_top_news() do
    validate_url()
    |> do_request()
    |> handle_response()
  end

  defp validate_url() do
    :hacker_news_api
    |> Application.get_env(HackerNewsApi.Config)
    |> Keyword.get(:top_news)
  end

  defp do_request(url) do
    HackerNewsApi.HTTPClient.get(url)
  end

  @impl true
  def build_response(response) do
    response
  end
end
