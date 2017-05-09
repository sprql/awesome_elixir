defmodule AwesomeElixir.AwesomeList.ImporterTest do
  use AwesomeElixir.DataCase

  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Importer}

  describe "import/1" do
    setup do
      {:ok, section} = AwesomeList.create_section(%{name: "test", description: "test"})
      {:ok, repository} = AwesomeList.create_repository(%{name: "test-lib-name", url: "https://github.com/test", description: "test", section_id: section.id})

      list = build_md_list()

      {:ok, list: list, repository: repository}
    end

    test "import list", context do
      Importer.import(context[:list])

      sections = Enum.into(AwesomeList.list_sections, [], &%{name: &1.name, description: &1.description})
      assert Enum.count(sections) == 3 + 1

      assert Enum.member?(sections, %{name: "Actors", description: "Libraries and tools for working with actors and such."})
      refute Enum.member?(sections, %{name: "Books", description: "Fantastic books and e-books."})

      repositories = Enum.into(AwesomeList.list_repositories, [], &%{name: &1.name, url: &1.url, description: &1.description})
      assert Enum.count(repositories) == 9

      assert Enum.member?(repositories, %{name: "dflow", url: "https://github.com/dalmatinerdb/dflow", description: "Pipelined flow processing engine."})
      refute Enum.member?(repositories, %{name: "Elixir in Action", url: "https://www.manning.com/books/elixir-in-action", description: "A brief intro to the language followed by a more detailed look at building production-ready systems in Elixir by Saša Jurić (2015)."})
      refute AwesomeElixir.Repo.get(AwesomeList.Repository, context[:repository].id)
    end
  end

  defp build_md_list do
    File.read!(Path.expand("../support/fixtures/awesome_elixir.md", __DIR__))
  end
end
