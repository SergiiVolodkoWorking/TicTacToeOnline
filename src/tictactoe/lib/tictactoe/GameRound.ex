defmodule Tictactoe.GameRound do
  @callback start(String, Map) :: Map

  alias Tictactoe.JsonRepository, as: JsonRepository

  # Space = %{
  #   EMPTY: 0,
  #   PLAYER_1: 1,
  #   PLAYER_2: 2,
  # }

  # GameState = %{
  #   NOT_STARTED : 0,
  #   PLAYER_1_MOVES: 1,
  #   PLAYER_2_MOVES: 2,
  #   PLAYER_WON: 3,
  #   DRAW: 4,
  # }


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
