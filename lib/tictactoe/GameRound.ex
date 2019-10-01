defmodule Tictactoe.GameRound do
  @callback start(String, Map) :: Map
  @callback apply_move(Map, Map) :: Map

  def start(game_id, setup) do
    empty = :EMPTY
    %{
      game_id: game_id,
      round_setup: setup,
      round_state: :PLAYER_1_MOVES,
      board: [empty, empty, empty,
              empty, empty, empty,
              empty, empty, empty]
    }
  end

  def apply_move(game_round, move) do
    board = game_round.board
    board = List.replace_at(board, move.space, move.player)

    round_state = get_round_state(board, move.player, game_round.round_state)

    Map.put(game_round, :round_state, round_state)
    |>Map.put(:board, board)
  end

  def get_round_state(board, player, currentState) do
    player1Moves = :PLAYER_1_MOVES
    player2Moves = :PLAYER_2_MOVES

    is_win = has_player_won(board, player)
    is_draw = !Enum.member?(board, :EMPTY)
    cond do
      is_win && currentState == player1Moves -> :PLAYER_1_WON
      is_win && currentState == player2Moves -> :PLAYER_2_WON
      is_draw -> :DRAW
      !is_win -> swap_players_turn(currentState)
      true -> currentState
    end
  end

  def swap_players_turn(currentState) do
    player1 = :PLAYER_1_MOVES
    player2 = :PLAYER_2_MOVES
    cond do
      currentState == player1 -> player2
      currentState == player2 -> player1
    end
  end

  def has_player_won(board, player) do
    # Horizontal
    (Enum.at(board, 0) == player && Enum.at(board, 1) == player && Enum.at(board, 2) == player) ||
    (Enum.at(board, 3) == player && Enum.at(board, 4) == player && Enum.at(board, 5) == player) ||
    (Enum.at(board, 6) == player && Enum.at(board, 7) == player && Enum.at(board, 8) == player) ||

    # Vertical
    (Enum.at(board, 0) == player && Enum.at(board, 3) == player && Enum.at(board, 6) == player) ||
    (Enum.at(board, 1) == player && Enum.at(board, 4) == player && Enum.at(board, 7) == player) ||
    (Enum.at(board, 2) == player && Enum.at(board, 5) == player && Enum.at(board, 8) == player) ||

    # Diagonals
    (Enum.at(board, 0) == player && Enum.at(board, 4) == player && Enum.at(board, 8) == player) ||
    (Enum.at(board, 2) == player && Enum.at(board, 4) == player && Enum.at(board, 6) == player)
  end
end
