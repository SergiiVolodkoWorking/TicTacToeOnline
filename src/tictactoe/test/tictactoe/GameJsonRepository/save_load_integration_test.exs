defmodule Tictactoe.GameJsonRepositoryTests do
  use ExUnit.Case
  alias Tictactoe.GameJsonRepository, as: Repository

  describe "Json Repository save/load integration" do
    test "saves map as json file and loads it from the file" do
      game = Forge.game_round
      id = game.game_id
      expected_file_name = "game-round-#{id}"
      expected_file_path = "./../../data/#{expected_file_name}.json"
      expected = Jason.decode!(Jason.encode!(game))

      # Save
      Repository.save(game)
      assert File.exists?(expected_file_path)

      # Load
      assert expected == Repository.load(id)
    end
  end
end
