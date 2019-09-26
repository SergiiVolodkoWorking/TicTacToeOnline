defmodule Tictactoe.Enums do
  def spaces do [:EMPTY, :PLAYER_1, :PLAYER_2] end

  def gameState do [
    :NOT_STARTED,
    :PLAYER_1_MOVES,
    :PLAYER_2_MOVES,
    :PLAYER_1_WON,
    :PLAYER_2_WON,
    :DRAW
  ]
  end

  def playerType do [:HUMAN, :BOT_EASY] end

end
