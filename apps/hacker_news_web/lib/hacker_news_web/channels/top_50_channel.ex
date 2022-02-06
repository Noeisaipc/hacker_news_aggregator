defmodule HackerNewsWeb.Top50Channel do
  @moduledoc """
  Handles events related with a users connected from device and send top 50 news
  """

  use Phoenix.Channel

  @spec join(String.t(), any(), Phoenix.Socket.t()) :: {:ok, Phoenix.Socket.t()} | {:error, map()}
  def join("news:top50", _params, socket) do
    news = HakerNewsCore.retrive_top_50()
    {:ok, news, socket}
  end

  def handle_in("news:send_new_top_50", news, socket) do
    broadcast!(socket, "news:send_new_top_50", news)
    {:noreply, socket}
  end
end
