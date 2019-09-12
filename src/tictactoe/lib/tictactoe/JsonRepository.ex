defmodule Tictactoe.JsonRepository do
  @callback save(String, Map) :: String
  @callback load(String) :: Map

  @directory "./../../data"

  def save(file_name, json_map) do

    if not File.exists?(@directory), do: File.mkdir!(@directory)
    file_path = "#{@directory}/#{file_name}.json"

    {:ok, content} = Jason.encode(json_map)
    File.write!(file_path, content)
  end

  def load(file_name) do
    file_path = "#{@directory}/#{file_name}.json"
    json_raw = File.read!(file_path)
    {:ok, content} = Jason.decode(json_raw)
    content
  end
end
