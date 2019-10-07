defmodule TictactoeWeb.GameController do
  use TictactoeWeb, :controller

  action_fallback TictactoeWeb.FallbackController
  alias Tictactoe.GameInMemoryRepository, as: Repository

  def create(conn, %{"game_id" => game_id, "opponent_type" => opponent_type}) do
    round =
      Game.create("#{game_id}", opponent_type)
      |> Repository.save

    json(conn, %{
      game_id: round.game_id,
      board: round.board
    })
  end

  def show(conn, %{"id" => game_id}) do
    round = Repository.load(game_id)
    json(conn, round)
  end

  def update(conn, %{"id" => game_id} = params) do
    taken_space = params["taken_space"]

    round =
      Repository.load(game_id)
      |> Game.make_move_against_bot(taken_space)
      |> Repository.save

    json(conn, %{"game_id" => round.game_id})
  end
end
