defmodule TictactoeWeb.Router do
  use TictactoeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TictactoeWeb do
    pipe_through :api

    resources "/version", VersionController, only: [:index]

    resources "/start_game", GameController, only: [:create]
    resources "/game", GameController, only: [:show]
    resources "/make_move", GameController, only: [:update]
  end

  scope "/", TictactoeWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
