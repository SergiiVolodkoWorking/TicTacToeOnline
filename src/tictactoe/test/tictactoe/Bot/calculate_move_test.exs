defmodule Tictactoe.BotTests do
  use ExUnit.Case
  alias Tictactoe.Bot, as: Bot

  describe "Easy bot takes an empty space" do
    test "when board is empty" do
      emptySpace = Fixtures.spaceEmpty
      game_round = Forge.game_round(
        board: [emptySpace, emptySpace, emptySpace,
                emptySpace, emptySpace, emptySpace,
                emptySpace, emptySpace, emptySpace])
      assert Bot.calculate_move(game_round) == 0
    end

    test "when player took a space" do
      emptySpace = Fixtures.spaceEmpty
      playerSpace = Tictactoe.Enums.space[:PLAYER_1]
      game_round = Forge.game_round(
        board: [playerSpace, emptySpace, emptySpace,
                emptySpace, emptySpace, emptySpace,
                emptySpace, emptySpace, emptySpace])
      assert Bot.calculate_move(game_round) == 1
    end

    test "when player and bot took a spces" do
      emptySpace = Fixtures.spaceEmpty
      playerSpace = Tictactoe.Enums.space[:PLAYER_1]
      botSpace = Tictactoe.Enums.space[:PLAYER_2]
      game_round = Forge.game_round(
        board: [playerSpace, botSpace, emptySpace,
                emptySpace, emptySpace, emptySpace,
                emptySpace, emptySpace, emptySpace])
      assert Bot.calculate_move(game_round) == 2
    end
  end
end
