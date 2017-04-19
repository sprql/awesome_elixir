defmodule AwesomeElixir.AwesomeList.Workflow do
  alias AwesomeElixir.AwesomeList.{Parser, Importer}

  def import_awesome_list(url \\ Application.get_env(:awesome_elixir, :awesome_list_url)) do
    response = Tesla.get(url)
    response.body
    |> String.split("\n")
    |> Parser.parse
    |> Importer.import
  end
end