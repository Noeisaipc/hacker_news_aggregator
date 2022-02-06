defmodule HackerNewsWeb.NewsUpdater do
  @moduledoc """
  Module for receive updates from NewsUpdater
  """
  use GenServer
  alias HackerNewsWeb.Endpoint, as: HackersSocket

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: name)
  end

  @impl true
  def init(nil) do
    {:ok, nil}
  end

  @impl true
  def handle_cast({:update, news}, _state) do
    HackersSocket.broadcast("news:top50", "news:send_new_top_50", news)
    {:noreply, news}
  end
end
