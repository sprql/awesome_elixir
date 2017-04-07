defmodule AwesomeElixir.Web.PageController do
  use AwesomeElixir.Web, :controller

  alias AwesomeElixir.AwesomeList

  def index(conn, _params) do
    sections = AwesomeList.list_sections_with_repositories
    render conn, "index.html", sections: sections
  end
end
