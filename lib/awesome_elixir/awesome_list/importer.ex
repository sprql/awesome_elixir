defmodule AwesomeElixir.AwesomeList.Importer do
  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Parser, GitHub}

  def import(url) do
    fetch_list(url)
    |> import_list
    |> delete_unlisted_repositories
    |> update_stats
  end

  defp fetch_list(url) do
    response = Tesla.get(url)
    response.body
    |> String.split("\n")
    |> Parser.parse
  end

  defp import_list(list) do
    Enum.map(list, &import_repository/1)
  end

  defp import_repository({section_struct, link_struct}) do
    with {:ok, section} <- create_section(section_struct),
         {:ok, repository} <- create_repository(link_struct, section)
    do
      repository
    else
      err -> err
    end
  end

  defp delete_unlisted_repositories(list) do
    current_repositories_names = AwesomeList.list_repositories_names()
    new_names = Enum.map(list, fn({_, repository}) -> repository.name end)
    unlisted_names = current_repositories_names -- new_names
    AwesomeList.delete_repositories_with_names(unlisted_names)
  end

  defp update_stats(list) do
    for repository <- AwesomeList.list_repositories, String.match?(repository.url, ~r[^https://github.com]) do
      with {:ok, attrs} <- GitHub.get_repo_stats(repository.url)
      do
        AwesomeList.update_repository(repository, attrs)
      end
    end
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
