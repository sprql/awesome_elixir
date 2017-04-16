defmodule AwesomeElixir.AwesomeList.ImporterTest do
  use AwesomeElixir.DataCase

  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Parser, Importer, Section, Repository}

  setup_all do
    path = Path.expand("../support/fixtures/awesome_elixir.md", __DIR__)
    list =
      path
      |> File.read!
      |> String.split("\n")

    {:ok, list: Parser.parse(list)}
  end

  test "import/1 import list", data do
    Importer.import(data[:list])

    sections = Enum.into(AwesomeList.list_sections, [], &%{name: &1.name, description: &1.description})
    assert Enum.count(sections) == 4

    assert Enum.member?(sections, %{name: "Actors", description: "Libraries and tools for working with actors and such."})
    assert Enum.member?(sections, %{name: "Books", description: "Fantastic books and e-books."})

    repositories = Enum.into(AwesomeList.list_repositories, [], &%{name: &1.name, url: &1.url, description: &1.description})
    assert Enum.count(repositories) == 12

    assert Enum.member?(repositories, %{name: "dflow", url: "https://github.com/dalmatinerdb/dflow", description: "Pipelined flow processing engine."})
    assert Enum.member?(repositories, %{name: "Elixir in Action", url: "https://www.manning.com/books/elixir-in-action", description: "A brief intro to the language followed by a more detailed look at building production-ready systems in Elixir by Saša Jurić (2015)."})
  end
end
