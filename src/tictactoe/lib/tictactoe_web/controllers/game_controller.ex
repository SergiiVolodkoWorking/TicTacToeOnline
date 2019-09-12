defmodule TictactoeWeb.GameController do
  use TictactoeWeb, :controller

  alias TictactoeWeb.Version

  action_fallback TictactoeWeb.FallbackController

  def create(conn, _params) do
    result = %{game_id: UUID.uuid1()}
    json(conn, result)
  end
end
