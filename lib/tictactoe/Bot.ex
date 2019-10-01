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
