defmodule Tictactoe.GameRound do
  @callback start(String, Map) :: Map
  @callback save(Map) :: String
  @callback load(String) :: Map

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

  def save(round) do
    file_name = "game-round-#{round.game_id}"
    JsonRepository.save(file_name, round)
    {:ok, round.game_id}
  end

  def load(game_id) do
    file_name = "game-round-#{game_id}"
    JsonRepository.load(file_name)
  end
end
