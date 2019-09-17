defmodule Tictactoe.Bot do
  @callback calculate_move(Map) :: integer

    def calculate_move(game_round) do
        playerSpace = Tictactoe.Enums.space[:PLAYER_1]
        botSpace = Tictactoe.Enums.space[:PLAYER_2]
        board = game_round.board
        Enum.find_index(board, fn s -> s != playerSpace && s != botSpace end)
    end
end
