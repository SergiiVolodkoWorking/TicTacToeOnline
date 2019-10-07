
defmodule GameRound do
  defstruct [:game_id, :round_setup, :round_state, :board]

  def start(game_id) do
    setup = %{
      first_player: %{type: :HUMAN, symbol: "X", code: :PLAYER_1},
      second_player: %{type: :BOT_EASY, symbol: "O", code: :PLAYER_2},
    }
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

  def update(round, round_state, board) do
    %{
      game_id: round.game_id,
      round_setup: round.round_setup,
      board: board,
      round_state: round_state
    }
  end
end




defmodule Tictactoe.GameRound do
  @callback apply_move(Map, Map) :: Map

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
