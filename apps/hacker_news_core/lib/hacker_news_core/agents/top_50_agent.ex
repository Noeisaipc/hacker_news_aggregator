defmodule HackerNewsCore.Top50Agent do
  use Agent

  @moduledoc """
  Documentation for `Top50Agent`.
  """
  def start_link(_initial_value) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def update(top_50_ids) do
    Agent.update(__MODULE__, fn _state -> top_50_ids end)
  end
end
