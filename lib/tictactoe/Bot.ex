defmodule Bot do
  def calculate_move(:PlayerWon, _, _, _, _), do: nil
  def calculate_move(:Draw, _, _, _, _), do: nil

  def calculate_move(:Playing, board, _, _, :BOT_EASY) do
    Board.available_spaces(board)
    |> BotIntellect.random_move
  end

  # def calculate_move(:Playing, board, opponent_player, bot_player, :BOT_HARD) do
  #   available_spaces = Board.available_spaces(board)
  #   move = BotIntellect.take_center(available_spaces)
  #   move = BotIntellect.get_winning_move(move, available_spaces, bot_player, board)
  #   move = BotIntellect.get_winning_move(move, available_spaces, opponent_player, board)
  #   move = BotIntellect.random_move(move, available_spaces)
  #   move
  # end
end












defmodule Tictactoe.Bot do
  @callback calculate_move(Map) :: integer

  def calculate_move(game_round) do
      player = :PLAYER_1
      bot = :PLAYER_2
      board = game_round.board
      space = Enum.find_index(
        board, fn s ->
          s != player &&
          s != bot end)

      %{
        space: space,
        player: bot
      }
  end
end
