defmodule TictactoeWeb.GameControllerTest do
  use TictactoeWeb.ConnCase

  test "POST /api/start_game/", %{conn: conn} do
    game_id = "id-to-create-game"
    conn = post(conn, "/api/start_game", %{game_id: game_id})

    actual = json_response(conn, 200)

    assert %{"game_id" => game_id } == actual
  end

end
