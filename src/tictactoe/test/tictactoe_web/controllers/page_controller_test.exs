defmodule TictactoeWeb.PageControllerTest do
  use TictactoeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "react-root"
  end
end
