defmodule AwesomeElixir.AwesomeList.ParserTest do
  use ExUnit.Case

  alias AwesomeElixir.AwesomeList.Parser
  alias AwesomeElixir.AwesomeList.Parser.{Section, Link}

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

    assert Enum.member?(list, {%Section{name: "Actors", description: "Libraries and tools for working with actors and such."},
                               %Link{name: "dflow", url: "https://github.com/dalmatinerdb/dflow"}})

    assert Enum.member?(list, {%Section{name: "Books", description: "Fantastic books and e-books."},
                               %Link{name: "Elixir in Action", url: "https://www.manning.com/books/elixir-in-action"}})
  end
end
