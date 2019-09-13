defmodule Tictactoe.GameService do
  @callback start_game(String, Map) :: Map

  alias Tictactoe.RoundSetupBuilder, as: RoundSetupBuilder
  alias Tictactoe.GameRound, as: GameRound
  alias Tictactoe.GameJsonRepository, as: GameRepository

  def start_game(game_id) do
    setup = RoundSetupBuilder.init_setup()
    round = GameRound.start(game_id, setup)
    saved_id = GameRepository.save(round)

    result = %{game_id: saved_id}
  end
end
