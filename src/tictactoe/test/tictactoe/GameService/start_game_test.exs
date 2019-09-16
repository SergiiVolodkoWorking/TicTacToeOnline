defmodule Tictactoe.GameServiceTests do
  use ExUnit.Case

  import Mockery
  import Mockery.Assertions

  alias Tictactoe.GameService, as: Service
  alias Tictactoe.RoundSetupBuilder, as: Builder
  alias Tictactoe.GameRound, as: Round
  alias Tictactoe.GameJsonRepository, as: Repo

  setup do
    mock Builder, :init_setup, %{}
    mock Round, :start, %{}
    mock Repo, :save, ""
    :ok
  end

  describe "when start is called" do
    test "initializes a game round and returns saved game id" do
      game_id  = Faker.UUID.v4()
      saved_id = Faker.UUID.v4()
      setup = Forge.round_setup
      round = Forge.game_round

      mock Builder, :init_setup, setup
      mock Round, :start, round
      mock Repo, :save, saved_id

      actual = Service.start_game(game_id)

      assert_called Builder, :init_setup
      assert_called Round, :start, [^game_id , ^setup]
      assert_called Repo, :save, [^round]

      expected = %{game_id: saved_id}

      assert actual == expected
    end
  end
end
