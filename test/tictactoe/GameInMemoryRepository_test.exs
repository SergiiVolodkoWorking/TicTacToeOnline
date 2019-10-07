defmodule Tictactoe.GameInMemoryRepositoryTests do
  use ExUnit.Case
  alias Tictactoe.GameInMemoryRepository, as: Repository

  describe "InMemory Repository save/load integration" do
    test "saves game in memory and loads it by id" do
      round = Forge.game_round

      saved = Repository.save(round)

      assert Repository.load(saved.game_id) == round
    end
  end
end
