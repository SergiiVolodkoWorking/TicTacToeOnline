defmodule GameRoundTests do
  use ExUnit.Case

  describe "when game round start is called" do
    test "initial game round is returned" do
      game_id = "test-id"

      round = %{
        game_id: game_id,
        round_state: :PLAYER_1_MOVES,
        board: Fixtures.emptyBoard,
        round_setup: %{
          first_player: %{type: :HUMAN, symbol: "X"},
          second_player: %{type: :BOT_EASY, symbol: "O"},
        }
      }

      assert GameRound.start(game_id) == round
    end
  end

end
