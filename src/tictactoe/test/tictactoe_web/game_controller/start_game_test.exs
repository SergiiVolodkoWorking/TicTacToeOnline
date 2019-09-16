defmodule TictactoeWeb.GameControllerTest do
  use TictactoeWeb.ConnCase
  alias Tictactoe.GameJsonRepository, as: Repo

  test "POST /api/start_game/", %{conn: conn} do
    game_id = "id-to-create-game"
    conn = post(conn, "/api/start_game", %{game_id: game_id})

    actual = json_response(conn, 200)

    assert %{"game_id" => game_id } == actual
  end

  test "GET /api/game/id", %{conn: conn} do
    game_round = Forge.game_round
    game_id = Repo.save(game_round)
    expected = Jason.decode!(Jason.encode!(game_round))

    url = "/api/game/#{game_id}"
    conn = get(conn, url)

    assert json_response(conn, 200) == expected
  end
end
