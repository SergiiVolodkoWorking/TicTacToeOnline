defmodule Tictactoe.GameRoundTests do
  use ExUnit.Case
  alias Tictactoe.GameRound, as: SUT

  describe "when game round start is called" do
    test "initial game state is returned" do

      emptySpace = Fixtures.spaceEmpty
      statePlayer1Moves = Map.fetch(Tictactoe.Enums.gameState, PLAYER_1_MOVES)
      game_id = "test-id"
      setup = Forge.round_setup

      expected = %{
        game_id: game_id,
        round_setup: setup,
        round_state: statePlayer1Moves,
        board: [emptySpace, emptySpace, emptySpace,
                emptySpace, emptySpace, emptySpace,
                emptySpace, emptySpace, emptySpace]
      }

      assert expected == SUT.start(game_id, setup)
    end
  end
end
