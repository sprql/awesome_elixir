defmodule AwesomeElixir.Web.PageControllerTest do
  use AwesomeElixir.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Awesome Elixir"
  end
end
