defmodule HackerNewsApi.HTTPClient do
  @moduledoc """
  Module for handling HTTP requests to Hackers News
  """
  require Logger
  @client Application.compile_env(:hacker_news_api, :http_client, HTTPoison)

  @spec get(String.t()) :: {:ok, struct()} | {:error, struct()}
  def get(url) do
    @client.get(url, headers())
  end

  defp headers() do
    [
      {"Content-Type", "application/json"}
    ]
  end
end
