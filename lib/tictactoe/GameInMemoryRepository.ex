defmodule Tictactoe.GameInMemoryRepository do
  @callback save(any ,Map) :: String
  @callback load(any, String) :: Map
  @callback init(any) :: any

  use Agent

  def init() do
    {:ok, repo} = Agent.start_link(fn -> %{} end)
    repo
  end

  def save(repo, round) do
    id = round.game_id
    Agent.update(repo, &Map.put(&1, id, round))
    id
  end

  def load(repo, game_id) do
    Agent.get(repo, &Map.get(&1, game_id))
  end
end
