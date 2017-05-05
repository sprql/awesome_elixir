defmodule AwesomeElixir.AwesomeList.Workflow do
  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Parser, Importer, GitHub}

  defmodule Import do
    def run(url) do
      list = fetch_list(url)

      Importer.import(list)
      delete_unlisted_repositories(list)
    end

    defp fetch_list(url) do
      response = Tesla.get(url)
      response.body
      |> String.split("\n")
      |> Parser.parse
    end

    defp delete_unlisted_repositories(list) do
      current_repositories_names = AwesomeList.list_repositories_names()
      new_names = Enum.map(list, fn({_, repository}) -> repository.name end)
      unlisted_names = current_repositories_names -- new_names
      AwesomeList.delete_repositories_with_names(unlisted_names)
    end
  end

  def update_github_stats do
    for repository <- AwesomeList.list_repositories, String.match?(repository.url, ~r[^https://github.com]) do
      with {:ok, attrs} <- GitHub.get_repo_stats(repository.url)
      do
        AwesomeList.update_repository(repository, attrs)
      end
    end
  end
end
