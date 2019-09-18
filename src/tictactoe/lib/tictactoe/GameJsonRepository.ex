defmodule Tictactoe.GameJsonRepository do
  @callback save(Map) :: String
  @callback load(String) :: Map

  @directory "./../../data"

  def save(round) do
    file_name = "game-round-#{round.game_id}.json"
    if not File.exists?(@directory), do: File.mkdir!(@directory)
    file_path = "#{@directory}/#{file_name}"

    {:ok, content} = Jason.encode(round)
    File.write!(file_path, content)

    round.game_id
  end

  def load(game_id) do
    file_name = "game-round-#{game_id}.json"
    file_path = "#{@directory}/#{file_name}"
    json_raw = File.read!(file_path)
    {:ok, content} = Jason.decode(json_raw, keys: :atoms)
    content
  end
end
