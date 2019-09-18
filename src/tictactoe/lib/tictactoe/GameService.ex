defmodule Tictactoe.GameService do
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
    move = %{
      space: space,
      player: Tictactoe.Enums.space[:PLAYER_1]
    }
    game_round = mockable(GameRepository).load(game_id)
    game_round = mockable(GameRound).apply_move(game_round, move)
    mockable(GameRepository).save(game_round)

    bot_move = mockable(Bot).calculate_move(game_round)
    game_round = mockable(GameRound).apply_move(game_round, bot_move)
    saved_id = mockable(GameRepository).save(game_round)

    %{game_id: saved_id}
  end
end
