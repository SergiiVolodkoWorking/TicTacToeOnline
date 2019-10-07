defmodule BotIntellect do
  def random_move(available_spaces), do: List.first(available_spaces)
  def random_move(nil, available_spaces), do: List.first(available_spaces)
  def random_move(move, _), do: move

  def take_center(available_spaces), do: Enum.find(available_spaces, fn s -> s == 4 end)

  def get_winning_move(available_spaces, player, board) do
    Enum.find(available_spaces,
          fn s -> case Board.apply_move(board, s, player) do
              {:PlayerWon, _} -> true
              {_, _} -> false
            end
          end)
    end
  def get_winning_move(nil, available_spaces, player, board), do: get_winning_move(available_spaces, player, board)
  def get_winning_move(move, _, _, _), do: move
end
