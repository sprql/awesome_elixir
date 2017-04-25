defmodule AwesomeElixir.AwesomeList.GitHub do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, %{
    "User-Agent"    => "Awesome-List-Agent",
    "Accept"        => "application/vnd.github.v3+json",
    "Authorization" => "token #{Application.get_env(:awesome_elixir, :github_access_token)}"
  }
  plug Tesla.Middleware.JSON

  def get_repo_stats(repo_url) do
    with [owner, repo_name | _] <- Regex.run(~r[^https://github.com/(.+?)/(.+?)(/.*)?$], repo_url, capture: :all_but_first),
         %{body: data, status: 200} <- get_repo(owner, repo_name),
         {:ok, pushed_at} <- NaiveDateTime.from_iso8601(data["pushed_at"])
    do
      stats = %{
        last_updated_at: pushed_at,
        stars: data["stargazers_count"]
      }

      {:ok, stats}
    else
      err -> err
    end
  end

  def get_repo(owner, name) do
    get("/repos/#{owner}/#{name}")
  end
end