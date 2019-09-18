defmodule Tictactoe.GameService do
  import Tictactoe.Enums
  import Mockery.Macro
  @callback start_game(String, Map) :: Map
  @callback get_game(String, Map) :: Map
  @callback make_move_against_bot(String, integer) :: Map

  alias Tictactoe.RoundSetupBuilder, as: RoundSetupBuilder
  alias Tictactoe.GameRound, as: GameRound
  alias Tictactoe.GameJsonRepository, as: GameRepository
  alias Tictactoe.Bot, as: Bot

  def start_game(game_id) do
    setup = mockable(RoundSetupBuilder).init_setup()
    game_round = mockable(GameRound).start(game_id, setup)
    saved_id = mockable(GameRepository).save(game_round)

    %{game_id: saved_id}
  end

  def get_game(game_id) do
    mockable(GameRepository).load(game_id)
  end

  def make_move_against_bot(game_id, space) do
    game_round = mockable(GameRepository).load(game_id)
    move = %{
      space: space,
      player: space()[:PLAYER_1]
    }

    game_round = execute_move(move, game_round)
    state = game_round.round_state
    cond do
      state == gameState()[:PLAYER_1_WON] || state == gameState()[:DRAW] -> game_round
      true -> mockable(Bot).calculate_move(game_round) |> execute_move(game_round)
    end
  end

  def execute_move(move, game_round) do
    game_round = mockable(GameRound).apply_move(game_round, move)
    mockable(GameRepository).save(game_round)
    game_round
  end
end
