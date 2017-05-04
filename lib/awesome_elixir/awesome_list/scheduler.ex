defmodule AwesomeElixir.AwesomeList.Scheduler do
  use GenServer

  @interval 12 * 60 * 60 * 1000 # 12 hours

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Task.Supervisor.start_child(AwesomeElixir.TaskSupervisor, fn ->
      AwesomeElixir.AwesomeList.Workflow.Import.run
    end)

    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, @interval)
  end
end
