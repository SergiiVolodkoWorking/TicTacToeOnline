defmodule TictactoeWeb.GameControllerTest do
  use TictactoeWeb.ConnCase

  test "POST /api/start_game/", %{conn: conn} do
    conn = post(conn, "/api/start_game", %{})

    actual = json_response(conn, 200)["game_id"]

    assert String.length(actual) == 36
  end
end
