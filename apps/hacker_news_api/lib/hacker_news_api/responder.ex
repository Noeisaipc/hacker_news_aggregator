defmodule HackerNewsApi.Responder do
  @moduledoc """
  Receives http responses from the client and handles them accordingly.

  HackerNews API modules (TopNews, etc) `use HakerNewsApi.Responder`. When a request
  is made they give the endpoint URL to the Client, which makes the request,
  and pass the response to `handle_response`. Each API module must build
  appropriate responses, so they add HakerNewsApi.Responder as a behaviour, and implement
  the `build_response/1` function.
  """

  @callback build_response(map) :: any

  defmacro __using__(_) do
    quote do
      require Logger
      @behaviour HackerNewsApi.Responder

      @doc false
      @spec handle_response(tuple()) :: :ok
      def handle_response({:ok, %HTTPoison.Response{status_code: code, body: ""}})
          when code in 200..299,
          do: :ok

      @doc false
      @spec handle_response(tuple()) :: {String.t(), map()}
      def handle_response({_message, %HTTPoison.Response{status_code: code, body: body}})
          when code in 300..499 do
        {:error, :resource_no_found}
      end

      @spec handle_response(tuple()) :: {String.t(), map()}
      def handle_response(
            {_message, %HTTPoison.Response{status_code: code, body: body} = response}
          )
          when code == 500 do
        Logger.error(fn -> "#{inspect(response)}" end)
        {:error, :invalid_resourse}
      end

      @doc false
      @spec handle_response(tuple()) :: {:ok, any()}
      def handle_response(
            {:ok,
             %HTTPoison.Response{status_code: _code, body: body, request: request} = response}
          ) do
        body |> Poison.decode!() |> build_response
      end

      @doc false
      @spec handle_response(tuple()) :: {:ok, any()}
      def handle_response(message) do
        Logger.error(fn -> "error message #{inspect(message)}" end)
        {:error, :communication}
      end
    end
  end
end
