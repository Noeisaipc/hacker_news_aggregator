defmodule HackerNewsCore.Monitor do
  @moduledoc """
  Module to handle the operations related to the ETS that saves news in cache.
  """
  @table_news :news

  @doc """
  it recives a tuple {news_id, news_data()}
  """
  @spec insert_news(tuple()) ::
          {:ok, String.t()} | {:error, String.t()}
  def insert_news({key, value}) do
    Cachex.put!(@table_news, key, value)
    key
  end

  # @spec find_news(register) :: map() | :id_no_found
  def find_news(key) do
    Cachex.get!(@table_news, key)
  end

  @spec get_news_table() :: {:ok, list}
  def get_news_table() do
    @table_news |> Cachex.keys!() |> Enum.sort(:desc) |> Enum.map(&find_news(&1))
  end
end
