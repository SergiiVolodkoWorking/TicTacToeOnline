defmodule Tictactoe.GameInMemoryRepositoryTests do
  use ExUnit.Case
  alias Tictactoe.GameInMemoryRepository, as: Repository

  describe "InMemory Repository save/load integration" do
    test "saves game in memory and loads it by id" do
      game = Forge.game_round
      id = game.game_id

      saved_id = Repository.save(game)
      assert Repository.load(saved_id) == game
    end
  end
end
