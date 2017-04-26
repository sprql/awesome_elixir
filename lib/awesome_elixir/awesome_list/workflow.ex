defmodule AwesomeElixir.AwesomeList.Workflow do
  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Parser, Importer, GitHub}

  def import_awesome_list(url \\ Application.get_env(:awesome_elixir, :awesome_list_url)) do
    response = Tesla.get(url)
    response.body
    |> String.split("\n")
    |> Parser.parse
    |> Importer.import
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