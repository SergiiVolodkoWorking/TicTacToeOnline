defmodule TictactoeWeb.GameController do
  use TictactoeWeb, :controller

  action_fallback TictactoeWeb.FallbackController
  alias Tictactoe.GameService, as: GameService

  def create(conn, %{"game_id" => game_id}) do
    result = GameService.start_game(game_id)
    json(conn, result)
  end
end
