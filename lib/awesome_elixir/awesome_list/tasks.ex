defmodule AwesomeElixir.AwesomeList.Tasks do
  def start_import_task do
    Task.Supervisor.start_child(AwesomeElixir.TaskSupervisor, &import_task/0)
  end

  def import_task do
    response = Tesla.get(Application.get_env(:awesome_elixir, :awesome_list_url))
    AwesomeElixir.AwesomeList.Importer.import(response.body)
  end
end
