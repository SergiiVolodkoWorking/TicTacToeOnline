defmodule TictactoeWeb.VersionController do
  use TictactoeWeb, :controller

  action_fallback TictactoeWeb.FallbackController

  def index(conn, _params) do
    result = %{version: "0.12"}
    json(conn, result)
  end
end