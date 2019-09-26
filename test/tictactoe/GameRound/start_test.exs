defmodule Tictactoe.GameRoundTests do
  use ExUnit.Case
  import Tictactoe.Enums
  alias Tictactoe.GameRound, as: GameRound

  describe "when game round start is called" do
    test "initial game state is returned" do
      statePlayer1Moves = gameState()[:PLAYER_1_MOVES]
      game_id = "test-id"
      setup = Forge.round_setup

      expected = %{
        game_id: game_id,
        round_setup: setup,
        round_state: statePlayer1Moves,
        board: Fixtures.emptyBoard
      }
      assert expected == GameRound.start(game_id, setup)
    end
  end

  describe "when move is applied" do
    test "empty board updates sucessfully by player 1 and turn goes to player 2" do
      player = Fixtures.randomPlayerSpace()
      game_round = Forge.game_round(
                          board: Fixtures.emptyBoard,
                          round_state: playerMovesState(player))

      empty = Fixtures.spaceEmpty
      opponent = other_player(player)
      opponents_turn = playerMovesState(opponent)
      expected_board = [player, empty, empty,
                        empty, empty, empty,
                        empty, empty, empty]

      move = %{
        space: 0,
        player: player
      }
      actual = GameRound.apply_move(game_round, move)

      assert actual.board == expected_board
      assert actual.round_state == opponents_turn
    end

    test "if player 1 finishes line victory goes to player 1" do
      statePlayer1Moves = gameState()[:PLAYER_1_MOVES]
      empty = Fixtures.spaceEmpty
      player1 = space()[:PLAYER_1]
      game_round = Forge.game_round(
        round_state: statePlayer1Moves,
        board: [player1, player1, empty,
                empty, empty, empty,
                empty, empty, empty])
      move = %{
        space: 2,
        player: player1
      }
      actual = GameRound.apply_move(game_round, move)

      assert actual.round_state == gameState()[:PLAYER_1_WON]
      assert actual.board ==[player1, player1, player1,
                              empty, empty, empty,
                              empty, empty, empty]
    end

    test "if player 2 finishes diagonal victory goes to player 2" do
      statePlayer2Moves = gameState()[:PLAYER_2_MOVES]
      empty = Fixtures.spaceEmpty
      player2 = space()[:PLAYER_2]
      game_round = Forge.game_round(
        round_state: statePlayer2Moves,
        board: [player2, empty, empty,
                empty, player2, empty,
                empty, empty, empty])
      move = %{
        space: 8,
        player: player2
      }
      actual = GameRound.apply_move(game_round, move)

      assert actual.round_state == gameState()[:PLAYER_2_WON]
      assert actual.board ==[player2, empty, empty,
                              empty, player2, empty,
                              empty, empty, player2]
    end

    test "if no more free spaces on a board - it's a draw" do
      empty = Fixtures.spaceEmpty
      player = Fixtures.randomPlayerSpace()
      opponent = other_player(player)
      game_round = Forge.game_round(
                      round_state: playerMovesState(player),
                      board: [player, player, opponent,
                              opponent, player, opponent,
                              player, opponent, empty])
      move = %{
        space: 8,
        player: player
      }
     actual = GameRound.apply_move(game_round, move)

     assert actual.round_state == gameState()[:DRAW]
    end
  end

  def other_player(player) do
    player1 = space()[:PLAYER_1]
    player2 = space()[:PLAYER_2]
    cond do
      player == player1 -> player2
      player == player2 -> player1
      true -> player
    end
  end

  def playerMovesState(player) do
    player1 = space()[:PLAYER_1]
    player2 = space()[:PLAYER_2]
    cond do
      player == player1 -> gameState()[:PLAYER_2_MOVES]
      player == player2 -> gameState()[:PLAYER_1_MOVES]
      true -> :error
    end
  end

end