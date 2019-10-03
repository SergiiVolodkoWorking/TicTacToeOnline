defmodule Tictactoe.GameServiceTests do
  use ExUnit.Case

  import Mockery
  import Mockery.Assertions

  alias Tictactoe.GameService, as: Service
  alias Tictactoe.RoundSetupBuilder, as: Builder
  alias Tictactoe.GameRound, as: Round
  alias Tictactoe.GameInMemoryRepository, as: Repo

  setup do
    mock(Builder, :init_setup, %{})
    mock(Round, :start, %{})
    mock(Repo, :save, "")
    :ok
  end

  describe "Game service" do
    test "when start is called initializes a game round and returns saved game id and initial board" do
      game_id  = Faker.UUID.v4()
      saved_id = Faker.UUID.v4()
      setup = Forge.round_setup
      round = Forge.game_round

      mock(Builder, :init_setup, setup)
      mock(Round, :start, round)
      mock(Repo, :save, saved_id)

      actual = Service.start_game(game_id)

      assert_called Builder, :init_setup
      assert_called Round, :start, [^game_id , ^setup]
      assert_called Repo, :save, [^round]

      expected = %{game_id: saved_id, board: round.board}

      assert actual == expected
    end

    test "when get game is called loads a game by id from Repo and returns it" do
      game_id = Faker.UUID.v4()
      round = Forge.game_round

      mock(Repo, :load, round)

      assert Service.get_game(game_id) == round
    end
  end

  describe "Player makes a move against bot" do
    test "winning move ends the game" do
      round = Forge.game_round()

      victory_round = Forge.game_round(
        round_state: :PLAYER_1_WON)

      mock(Repo, :load, round)
      mock(Round, [apply_move: 2], fn(input_round, _) ->
                                      cond do
                                        input_round == round -> victory_round
                                        true -> %{}
                                      end
                                    end)

      game_id = Faker.UUID.v4()
      moveSpace = Fixtures.randomSpaceIndex()

      assert Service.make_move_against_bot(game_id, moveSpace) == victory_round
    end

    test "draw move ends the game" do
      round = Forge.game_round()

      draw_round = Forge.game_round(
        round_state: :DRAW)

      mock(Repo, :load, round)
      mock(Round, [apply_move: 2], fn(input_round, _) ->
                                      cond do
                                        input_round == round -> draw_round
                                        true -> %{}
                                      end
                                    end)

      game_id = Faker.UUID.v4()
      moveSpace = Fixtures.randomSpaceIndex()

      assert Service.make_move_against_bot(game_id, moveSpace) == draw_round
    end

    test "their move doesn't end the game returns round result after bot" do
      round = Forge.game_round()
      round_after_player = Forge.game_round(
        round_state: :PLAYER_2_MOVES)
      round_after_bot = Forge.game_round()

      mock(Repo, :load, round)
      mock(Round, [apply_move: 2], fn(input_round, _) ->
                                      cond do
                                        input_round == round -> round_after_player
                                        input_round == round_after_player -> round_after_bot
                                        true -> %{}
                                      end
                                    end)

      game_id = Faker.UUID.v4()
      moveSpace = Fixtures.randomSpaceIndex()

      assert Service.make_move_against_bot(game_id, moveSpace) == round_after_bot
    end
  end

end
