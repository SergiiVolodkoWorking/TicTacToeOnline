defmodule TictactoeWeb.GameControllerTest do
  use TictactoeWeb.ConnCase
  alias Tictactoe.GameInMemoryRepository, as: Repo

  describe "Game round" do
    test "Player can start the round", %{conn: conn} do
      game_id = "id-to-create-game"
      conn = post(conn, "/api/start_game", %{game_id: game_id, opponent_type: "bot_easy"})

      actual = json_response(conn, 200)

      expected = Jason.decode!(Jason.encode!(%{
        game_id: game_id,
        board: Fixtures.emptyBoard
      }))

      assert actual == expected
    end

    test "Game can check current round state", %{conn: conn} do
      game_round = Forge.game_round()
      Repo.save(game_round)
      expected = Jason.decode!(Jason.encode!(game_round))

      game_id = game_round.game_id

      url = "/api/game/#{game_id}"
      conn = get(conn, url)

      assert json_response(conn, 200) == expected
    end
  end

  describe "Player makes move against bot (PUT /api/make_move)" do
    test "their winning move ends the game", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = :PLAYER_1
      game_round = Forge.game_round_vs_easy_bot(
        game_id: "test-make-move",
        board: [player1, player1, empty,
                empty, empty, empty,
                empty, empty, empty])

      game_id = game_round.game_id
      Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_round.game_id, taken_space: 2}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == :PLAYER_1_WON
      assert actual.board == [player1, player1, player1,
                              empty, empty, empty,
                              empty, empty, empty]
    end

    test "their draw move ends the game", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = :PLAYER_1
      player2 = :PLAYER_2
      game_round = Forge.game_round_vs_easy_bot(
        board: [player1, player2, player2,
                player2, player1, player1,
                player1, empty, player2])

      game_id = game_round.game_id
      Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_round.game_id, taken_space: 7}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == :DRAW
      assert actual.board == [player1, player2, player2,
                              player2, player1, player1,
                              player1, player1, player2]
    end

    test "their move doesn't end the game and bot wins", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = :PLAYER_1
      player2 = :PLAYER_2
      game_round = Forge.game_round_vs_easy_bot(
        board: [player2, player2, empty,
                player1, empty, empty,
                empty, empty, empty])

      game_id = game_round.game_id
      Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_round.game_id, taken_space: 4}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == :PLAYER_2_WON
      assert actual.board == [player2, player2, player2,
                              player1, player1, empty,
                              empty, empty, empty]
    end

    test "their move doesn't end the game but bot's makes draw", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = :PLAYER_1
      player2 = :PLAYER_2
      game_round = Forge.game_round_vs_easy_bot(
        board: [player1, player2, player2,
                player2, player1, player1,
                player1, empty, empty])

      game_id = game_round.game_id
      Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_round.game_id, taken_space: 7}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == :DRAW
      assert actual.board == [player1, player2, player2,
                              player2, player1, player1,
                              player1, player1, player2]
    end

    test "their move doesn't end the game and bot's move doesn't end it", %{conn: conn} do
      empty = Fixtures.spaceEmpty
      player1 = :PLAYER_1
      player2 = :PLAYER_2
      game_round = Forge.game_round_vs_easy_bot(
        board: [player2, empty, empty,
                player1, empty, empty,
                empty, empty, empty])

      game_id = game_round.game_id
      Repo.save(game_round)
      url = "/api/make_move/#{game_id}"
      body = %{game_id: game_id, taken_space: 4}

      conn = put(conn, url, body)
      json_response(conn, 200)
      actual = Repo.load(game_id)

      assert actual.round_state == :PLAYER_1_MOVES
      assert actual.board == [player2, player2, empty,
                              player1, player1, empty,
                              empty, empty, empty]
    end
  end
end
