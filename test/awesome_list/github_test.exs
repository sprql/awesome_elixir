defmodule AwesomeElixir.AwesomeList.GitHubTest do
  use ExUnit.Case

  alias AwesomeElixir.AwesomeList.GitHub

  test "get_repo_stats/1 returns repo stats" do
    assert {:ok, %{last_updated_at: _, stars: _}} = GitHub.get_repo_stats("https://github.com/dalmatinerdb/dflow")
  end
end
