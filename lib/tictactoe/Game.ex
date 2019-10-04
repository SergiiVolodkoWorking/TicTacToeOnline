defmodule Game do
  def create(game_id) do
    GameRound.start(game_id)
  end
end
