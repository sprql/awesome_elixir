defmodule AwesomeElixir.AwesomeList.ParserTest do
  use ExUnit.Case

  alias AwesomeElixir.AwesomeList.Parser

  setup_all do
    path = Path.expand("../support/fixtures/awesome_list.md", __DIR__)
    list =
      path
      |> File.read!
      |> Enum.split("\n")

    {:ok, lines}
  end

  test "parse/1 returns parsed awesome list", lines do
    list = Parser.parse(lines)
    assert Enum.member?(list, {:subsection, "Actors"})
    assert Enum.member?(list, {:subsection_description, "Libraries and tools for working with actors and such."})
    assert Enum.member?(list, {:link, "dflow", "https://github.com/dalmatinerdb/dflow"})
  end
end
