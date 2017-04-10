defmodule AwesomeElixir.AwesomeList.ParserTest do
  use ExUnit.Case

  alias AwesomeElixir.AwesomeList.Parser

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
    assert Enum.member?(list, {:subsection, "Actors"})
    assert Enum.member?(list, {:subsection_description, "Libraries and tools for working with actors and such."})
    assert Enum.member?(list, {:link, "dflow", "https://github.com/dalmatinerdb/dflow"})
  end
end
