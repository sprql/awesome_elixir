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

    section = %Section{name: "Actors", description: "Libraries and tools for working with actors and such."}
    link = %Link{name: "dflow", url: "https://github.com/dalmatinerdb/dflow", description: "Pipelined flow processing engine."}
    assert Enum.member?(list, {section, link})

    section = %Section{name: "Books", description: "Fantastic books and e-books."}
    link = %Link{name: "Elixir in Action", url: "https://www.manning.com/books/elixir-in-action", description: "A brief intro to the language followed by a more detailed look at building production-ready systems in Elixir by Saša Jurić (2015)."}
    refute Enum.member?(list, {section, link})
  end
end
