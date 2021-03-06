defmodule Tictactoe.GameInMemoryRepository do
  use Agent

  @entityName :GameRound

  def start_link(_args) do
    Agent.start_link(fn -> %{} end, name: @entityName)
  end

  def save(round) do
    id = round.game_id
    Agent.update(@entityName, fn state -> Map.put(state, id, round) end)
    round
  end

  def load(game_id) do
    Agent.get(@entityName, fn state -> Map.get(state, game_id) end)
  end
end
