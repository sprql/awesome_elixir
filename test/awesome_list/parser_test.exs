defmodule AwesomeElixir.AwesomeList.ParserTest do
  use ExUnit.Case

  alias AwesomeElixir.AwesomeList.Parser
  alias AwesomeElixir.AwesomeList.Parser.Entity

  setup_all do
    path = Path.expand("../support/fixtures/awesome_elixir.md", __DIR__)
    list =
      path
      |> File.read!
      |> String.split("\n")

    {:ok, list: list}
  end

  test "parse/1 returns parsed awesome list", data do
    list = Parser.parse(data[:list])

    assert Enum.member?(list, %Entity{name: "dflow",
                                      section: {"Actors", "Libraries and tools for working with actors and such."},
                                      url: "https://github.com/dalmatinerdb/dflow"})

    assert Enum.member?(list, %Entity{name: "Elixir in Action",
                                      section: {"Books", "Fantastic books and e-books."},
                                      url: "https://www.manning.com/books/elixir-in-action"})
  end
end
