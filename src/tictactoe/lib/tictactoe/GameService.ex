defmodule Tictactoe.GameService do
  import Mockery.Macro
  @callback start_game(String, Map) :: Map

  alias Tictactoe.RoundSetupBuilder, as: RoundSetupBuilder
  alias Tictactoe.GameRound, as: GameRound
  alias Tictactoe.GameJsonRepository, as: GameRepository

  def start_game(game_id) do
    setup = mockable(RoundSetupBuilder).init_setup()
    round = mockable(GameRound).start(game_id, setup)
    saved_id = mockable(GameRepository).save(round)

    %{game_id: saved_id}
  end
end
