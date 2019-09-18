defmodule Tictactoe.Bot do
  @callback calculate_move(Map) :: integer

  def calculate_move(game_round) do
      player = Tictactoe.Enums.space[:PLAYER_1]
      bot = Tictactoe.Enums.space[:PLAYER_2]
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
