defmodule Tictactoe.Enums do
  def space, do: %{
    EMPTY: 0,
    PLAYER_1: 1,
    PLAYER_2: 2
  }

  def gameState, do: %{
    NOT_STARTED: 0,
    PLAYER_1_MOVES: 1,
    PLAYER_2_MOVES: 2,
    PLAYER_WON: 3,
    DRAW: 4
  }

  def playerType, do: %{
    HUMAN: 0,
    BOT_EASY: 1
  }
end
