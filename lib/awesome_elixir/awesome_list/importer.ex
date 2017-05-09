defmodule AwesomeElixir.AwesomeList.Importer do
  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Repository, Parser, GitHub}

  def import(list) do
    list
    |> parse_list
    |> import_list
    |> filter_imported
    |> delete_unlisted_repositories
    |> update_github_stats
  end

  defp update_github_stats(list) do
    for repository <- list do
      with {:ok, attrs} <- GitHub.get_repo_stats(repository.url)
      do
        AwesomeList.update_repository(repository, attrs)
      end
    end
  end

  defp parse_list(list) do
    list
    |> String.split("\n")
    |> Parser.parse
  end

  defp import_list(parsed_list) do
    for {section_struct, link_struct} <- parsed_list, String.match?(link_struct.url, ~r[^https://github.com]) do
      import_repository(section_struct, link_struct)
    end
  end

  defp import_repository(section_struct, link_struct) do
    with {:ok, section} <- create_section(section_struct),
         {:ok, repository} <- create_repository(link_struct, section)
    do
      repository
    else
      err -> err
    end
  end

  defp filter_imported(list) do
    Enum.filter(list, &match?(%Repository{}, &1))
  end

  defp delete_unlisted_repositories(list) do
    current_repositories_names = AwesomeList.list_repositories_names()
    new_names = Enum.map(list, &(&1.name))
    unlisted_names = current_repositories_names -- new_names
    AwesomeList.delete_repositories_with_names(unlisted_names)
    list
  end

  defp create_section(section) do
    section
    |> Map.from_struct
    |> AwesomeList.create_or_update_section
  end

  defp create_repository(link, section) do
    link
    |> Map.from_struct
    |> Map.put(:section_id, section.id)
    |> AwesomeList.create_or_update_repository
  end
end
