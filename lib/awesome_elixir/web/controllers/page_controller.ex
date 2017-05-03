defmodule AwesomeElixir.Web.PageController do
  use AwesomeElixir.Web, :controller

  alias AwesomeElixir.AwesomeList

  def index(conn, params) do
  	min_stars = String.to_integer(params["min_stars"] || "0")
    repositories = AwesomeList.list_repositories_with_stars(min_stars)
    render conn, "index.html", repositories: repositories
  end
end
