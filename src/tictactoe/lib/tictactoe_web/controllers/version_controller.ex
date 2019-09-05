defmodule TictactoeWeb.VersionController do
  use TictactoeWeb, :controller

  alias TictactoeWeb.Version

  action_fallback TictactoeWeb.FallbackController

  def index(conn, _params) do
    result = %{version: "0.11"}
    json(conn, result)
  end
end
