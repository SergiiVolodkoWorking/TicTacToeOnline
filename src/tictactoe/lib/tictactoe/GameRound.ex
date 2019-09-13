defmodule Tictactoe.GameRound do
  @callback start(String, Map) :: Map

  alias Tictactoe.JsonRepository, as: JsonRepository

  def start(game_id, setup) do
    %{
      game_id: game_id,
      round_setup: setup,
      round_state: :PLAYER_1_MOVES,
      board: [:EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE,
              :EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE,
              :EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE]
    }
  end
end
