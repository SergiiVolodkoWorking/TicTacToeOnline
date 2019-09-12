defmodule Tictactoe.GameRoundTests do
  use ExUnit.Case
  alias Tictactoe.GameRound, as: SUT

  describe "when game round start is called" do
    test "initial game state is returned" do

      game_id = "test-id"
      setup = %{
        first_player: %{type: :HUMAN, symbol: "X"},
        second_player: %{type: :BOT_EASY, symbol: "O"},
      }
      expected = %{
        game_id: game_id,
        round_setup: setup,
        round_state: :PLAYER_1_MOVES,
        board: [:EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE,
                :EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE,
                :EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE]
      }

      assert expected == SUT.start(game_id, setup)
    end
  end

  # describe "Game round save/load integration" do
  #   test "happy path" do
  #     game_id = "integration-test-round-id"
  #     game_round = %{
  #       game_id: game_id,
  #       round_setup: %{
  #         first_player: %{type: :HUMAN, symbol: "X"},
  #         second_player: %{type: :HUMAN, symbol: "Y"},
  #       },
  #       round_state: :PLAYER_2_MOVES,
  #       board: [:EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE,
  #               :EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE,
  #               :EMPTY_SPACE,:EMPTY_SPACE,:EMPTY_SPACE]
  #     }

  #     SUT.save(game_round)

  #     assert game_round == SUT.load(game_id)
  #   end
  # end
end
