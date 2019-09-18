defmodule TictactoeWeb.GameController do
  use TictactoeWeb, :controller

  action_fallback TictactoeWeb.FallbackController
  alias Tictactoe.GameService, as: GameService

  def create(conn, %{"game_id" => game_id}) do
    result = GameService.start_game(game_id)
    json(conn, result)
  end

  def show(conn, %{"id" => game_id}) do
    result = GameService.get_game(game_id)
    json(conn, result)
  end

  def update(conn, %{"id" => game_id} = params) do
    taken_space = params["taken_space"]
    result = GameService.make_move_against_bot(game_id, taken_space)
    json(conn, result)
  end
end
