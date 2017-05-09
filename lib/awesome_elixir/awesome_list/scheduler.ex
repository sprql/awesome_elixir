defmodule AwesomeElixir.AwesomeList.Scheduler do
  use GenServer

  alias AwesomeElixir.AwesomeList.Tasks

  @interval 12 * 60 * 60 * 1000 # 12 hours

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    Tasks.start_import_task

    {:ok, state}
  end

  def handle_info(:work, state) do
    Tasks.start_import_task

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, @interval)
  end
end
