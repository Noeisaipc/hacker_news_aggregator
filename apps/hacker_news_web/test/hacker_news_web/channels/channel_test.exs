defmodule HackerNewsWeb.NewsChannelTest do
  use HackerNewsWeb.ChannelCase
  alias HackerNewsWeb.Top50Channel
  alias HackerNewsWeb.UserSocket

  setup do
    {:ok, _news, socket} =
      UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(Top50Channel, "news:top50")

    %{socket: socket}
  end

  test "broadcast_50_top_news", %{socket: socket} do
    push(socket, "news:send_new_top_50", HackerNewsCore.retrive_top_50())
    assert_broadcast("news:send_new_top_50", _news)
  end

  test "fecht_news_on_connect", %{} do
    {:ok, news, _socket} =
      UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(Top50Channel, "news:top50")

    assert news == HackerNewsCore.retrive_top_50()
  end
end
