defmodule Bot do
  def calculate_move(:PlayerWon, _, _, _, _), do: nil
  def calculate_move(:Draw, _, _, _, _), do: nil

  def calculate_move(:Playing, board, _, _, :BOT_EASY) do
    board
    |> Board.available_spaces
    |> BotIntellect.random_move
  end

  def calculate_move(:Playing, board, opponent_player, bot_player, :BOT_HARD) do
    available_spaces = Board.available_spaces(board)
    available_spaces
    |> BotIntellect.take_center
    |> BotIntellect.get_winning_move(available_spaces, bot_player, board)
    |> BotIntellect.get_winning_move(available_spaces, opponent_player, board)
    |> BotIntellect.random_move(available_spaces)
  end
end
