defmodule HackerNewsApi.Item do
  @moduledoc """
  Module for creating the required structure for spei transfer
  """
  use HackerNewsApi.Responder
  require Logger

  @spec fetch(Integer.t()) :: map()
  def fetch(item_id) do
    validate_url(item_id)
    |> do_request()
    |> handle_response()
  end

  defp validate_url(item_id) do
    :hacker_news_api
    |> Application.get_env(HackerNewsApi.Config)
    |> Keyword.get(:news_info)
    |> String.replace("ID", "#{item_id}")
  end

  defp do_request(url) do
    HackerNewsApi.HTTPClient.get(url)
  end

  defp parse_unix_date(unix_time) do
    DateTime.from_unix!(unix_time) |> DateTime.to_iso8601()
  end

  @impl true
  def build_response(nil) do
    %{}
  end

  def build_response(response) do
    %{
      id: response["id"],
      deleted: response["deleted"] || false,
      type: response["type"],
      by: response["by"],
      time: parse_unix_date(response["time"]),
      text: response["text"],
      dead: response["dead"],
      parent: response["parent"],
      poll: response["poll"],
      kids: response["kids"],
      url: response["url"],
      score: response["score"],
      title: response["title"],
      parts: response["parts"],
      descendants: response["descendants"]
    }
  end
end
