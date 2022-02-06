defmodule HackerNewsCore.WorkerUpdater do
  @moduledoc """
  Worker Updater for News
  """
  use GenServer

  def start_link(_time) do
    GenServer.start_link(__MODULE__, 300)
  end

  def init(time) do
    update_data()
    refresh(time)
    {:ok, %{time: time}}
  end

  def handle_info(:refresh, state) do
    update_data()
    refresh(state.time)
    {:noreply, %{time: state}}
  end

  defp refresh(time_in_seconds) do
    Process.send_after(self(), :refresh, time_in_seconds * 1000)
  end

  defp update_data() do
    HackerNewsCore.fetch_top_news()
    HackerNewsCore.brocast_top_news()
  end
end
