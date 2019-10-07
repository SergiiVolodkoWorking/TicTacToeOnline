defmodule BotTests do
  use ExUnit.Case

  describe "calculate move" do
    test "player already won - do nothing" do
      board = Fixtures.randomBoard
      first_player = Forge.player
      second_player = Forge.player

      assert Bot.calculate_move(:PlayerWon, board, first_player, second_player, :ANY_TYPE) == nil
    end

    test "there is already a draw - do nothing" do
      board = Fixtures.randomBoard
      first_player = Forge.player
      second_player = Forge.player

      assert Bot.calculate_move(:Draw, board, first_player, second_player, :ANY_TYPE) == nil
    end

    test "Easy bot makes a random move" do
      board = [:NotEmpty, :EMPTY, :EMPTY]
      first_player = Forge.player
      second_player = Forge.player

      assert Bot.calculate_move(:Playing, board, first_player, second_player, :BOT_EASY) == 1
    end
  end
end
