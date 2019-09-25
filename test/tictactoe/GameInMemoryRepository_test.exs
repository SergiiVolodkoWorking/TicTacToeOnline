defmodule Tictactoe.GameInMemoryRepositoryTests do
  use ExUnit.Case
  alias Tictactoe.GameInMemoryRepository, as: Repository

  describe "InMemory Repository save/load integration" do
    test "saves game in memory and loads it by id" do
      game = Forge.game_round
      id = game.game_id
      repo = Repository.init()

      # Save
      Repository.save(repo, game)

      # Load
      assert Repository.load(repo, id) == game
    end
  end
end
