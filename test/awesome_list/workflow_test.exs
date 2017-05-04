defmodule AwesomeElixir.AwesomeList.WorkflowTest do
  use AwesomeElixir.DataCase

  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.Workflow

  test "Import.run/1 import awesome list from url" do
    Workflow.Import.run

    repositories = Enum.into(AwesomeList.list_repositories, [], &%{name: &1.name, url: &1.url, description: &1.description})
    assert Enum.count(repositories) > 1000

    assert Enum.member?(repositories, %{name: "dflow", url: "https://github.com/dalmatinerdb/dflow", description: "Pipelined flow processing engine."})
    refute Enum.member?(repositories, %{name: "Elixir in Action", url: "https://www.manning.com/books/elixir-in-action", description: "A brief intro to the language followed by a more detailed look at building production-ready systems in Elixir by Saša Jurić (2015)."})
  end
end
