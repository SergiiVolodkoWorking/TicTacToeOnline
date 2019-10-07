defmodule BotIntellect do
  def random_move(available_spaces), do: List.first(available_spaces)
  def random_move(nil, available_spaces), do: List.first(available_spaces)
  def random_move(move, _), do: move

  def take_center(available_spaces), do: Enum.find(available_spaces, fn s -> s == 4 end)

  def get_winning_move(move, _, _, _), do: move
  def get_winning_move(nil, available_spaces, player, board) do
    boardModel = board#clone?

    Enum.find(available_spaces, fn s -> Board.apply_move(boardModel, s, player.code) == :PlayerWon end)
  end
end
