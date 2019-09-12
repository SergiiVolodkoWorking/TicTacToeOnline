defmodule TictactoeWeb.GameController do
  use TictactoeWeb, :controller

  action_fallback TictactoeWeb.FallbackController

  alias Tictactoe.RoundSetupBuilder, as: RoundSetupBuilder
  alias Tictactoe.GameRound, as: GameRound


  def create(conn, %{"game_id" => game_id}) do
    setup = RoundSetupBuilder.init_setup()
    round = GameRound.start(game_id, setup)
    {:ok, saved_id} = GameRound.save(round)

    result = %{game_id: saved_id}
    json(conn, result)
  end
end
