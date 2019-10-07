defmodule Tictactoe.Rules do
  def is_draw(board) do
    !Enum.member?(board, :EMPTY)
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
