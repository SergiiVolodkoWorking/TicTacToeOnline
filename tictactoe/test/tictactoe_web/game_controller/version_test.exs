defmodule TictactoeWeb.VersionControllerTest do
  use TictactoeWeb.ConnCase

  test "GET /api/version", %{conn: conn} do
    conn = get(conn, "/api/version")

    expected_json = json_from("version_fetched_successfully.json")

    assert json_response(conn, 200) == expected_json
  end
end
