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
          first_player: %{type: :HUMAN, symbol: "X", code: :PLAYER_1},
          second_player: %{type: :BOT_EASY, symbol: "O", code: :PLAYER_2},
        }
      }

      assert GameRound.start(game_id) == round
    end
  end

  describe "when update round is called" do
    test "new round is returned for game continuation" do
      round = Forge.game_round
      state = Fixtures.randomGameState
      board = Fixtures.randomBoard
      expected = %{
        game_id: round.game_id,
        round_state: state,
        board: board,
        round_setup: round.round_setup
      }

      assert GameRound.update(round, state, board) == expected
    end
  end
end
