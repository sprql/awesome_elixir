defmodule AwesomeElixir.AwesomeList.Workflow do
  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Parser, Importer, GitHub}

  defmodule Import do
    def run(url \\ Application.get_env(:awesome_elixir, :awesome_list_url)) do
      list = fetch_list(url)
      Importer.import(list)
    end

    defp fetch_list(url) do
      response = Tesla.get(url)
      response.body
      |> String.split("\n")
      |> Parser.parse
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
