defmodule Tictactoe.GameInMemoryRepository do
  @callback save(Map) :: String
  @callback load(String) :: Map
  @callback start_link(any) :: any

  use Agent

  @entityName :GameRound

  def start_link(_args) do
    Agent.start_link(fn -> %{} end, name: @entityName)
  end

  def save(round) do
    id = round.game_id
    IO.inspect(round)
    Agent.update(@entityName, fn state -> Map.put(state, id, round) end)
    id
  end

  def load(game_id) do
    Agent.get(@entityName, fn state -> Map.get(state, game_id) end)
  end
end
