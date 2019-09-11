defmodule TictactoeWeb.GameControllerTest do
  use TictactoeWeb.ConnCase

  test "POST /api/start_game", %{conn: conn} do
    conn = post(conn, "/api/start_game", %{})

    expected_json = json_from("game_successfully_started.json")

    assert json_response(conn, 200) == expected_json
  end
end
