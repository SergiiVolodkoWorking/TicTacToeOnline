defmodule TictactoeWeb.GameControllerTest do
  use TictactoeWeb.ConnCase
  import Tictactoe.Enums
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

  describe "Player makes move against bot (PUT /api/make_move)" do
    test "their winning move ends the game", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = space()[:PLAYER_1]
      game_round = Forge.game_round(
        round_state: gameState()[:PLAYER_1_MOVES],
        board: [player1, player1, empty,
                empty, empty, empty,
                empty, empty, empty])

      game_id = Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_id, taken_space: 2}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == gameState()[:PLAYER_1_WON]
      assert actual.board == [player1, player1, player1,
                              empty, empty, empty,
                              empty, empty, empty]
    end

    test "their draw move ends the game", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = space()[:PLAYER_1]
      player2 = space()[:PLAYER_2]
      game_round = Forge.game_round(
        round_state: gameState()[:PLAYER_1_MOVES],
        board: [player1, player2, player2,
                player2, player1, player1,
                player1, empty, player2])

      game_id = Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_id, taken_space: 7}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == gameState()[:DRAW]
      assert actual.board == [player1, player2, player2,
                              player2, player1, player1,
                              player1, player1, player2]
    end

    test "their move doesn't end the game and bot wins", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = space()[:PLAYER_1]
      player2 = space()[:PLAYER_2]
      game_round = Forge.game_round(
        round_state: gameState()[:PLAYER_1_MOVES],
        board: [player2, player2, empty,
                player1, empty, empty,
                empty, empty, empty])

      game_id = Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_id, taken_space: 4}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == gameState()[:PLAYER_2_WON]
      assert actual.board == [player2, player2, player2,
                              player1, player1, empty,
                              empty, empty, empty]
    end

    test "their move doesn't end the game but bot's makes draw", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = space()[:PLAYER_1]
      player2 = space()[:PLAYER_2]
      game_round = Forge.game_round(
        round_state: gameState()[:PLAYER_1_MOVES],
        board: [player1, player2, player2,
                player2, player1, player1,
                player1, empty, empty])

      game_id = Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_id, taken_space: 7}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == gameState()[:DRAW]
      assert actual.board == [player1, player2, player2,
                              player2, player1, player1,
                              player1, player1, player2]
    end

    test "their move doesn't end the game and bot's move doesn't end it", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = space()[:PLAYER_1]
      player2 = space()[:PLAYER_2]
      game_round = Forge.game_round(
        round_state: gameState()[:PLAYER_1_MOVES],
        board: [player2, empty, empty,
                player1, empty, empty,
                empty, empty, empty])

      game_id = Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_id, taken_space: 4}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == gameState()[:PLAYER_1_MOVES]
      assert actual.board == [player2, player2, empty,
                              player1, player1, empty,
                              empty, empty, empty]
    end
  end
end
