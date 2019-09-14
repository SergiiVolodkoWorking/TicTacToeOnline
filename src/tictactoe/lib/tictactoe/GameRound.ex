defmodule Tictactoe.GameRound do
  @callback start(String, Map) :: Map

  #import Tictactoe.Enums

  def start(game_id, setup) do
    empty = Map.fetch(Tictactoe.Enums.space, EMPTY)
    %{
      game_id: game_id,
      round_setup: setup,
      round_state: Map.fetch(Tictactoe.Enums.gameState, PLAYER_1_MOVES),
      board: [empty, empty, empty,
              empty, empty, empty,
              empty, empty, empty]
    }
  end
end
