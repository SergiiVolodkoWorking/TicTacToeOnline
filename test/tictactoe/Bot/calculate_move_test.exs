defmodule Tictactoe.BotTests do
  import Tictactoe.Enums
  use ExUnit.Case
  alias Tictactoe.Bot, as: Bot

  describe "Easy bot takes an empty space" do
    def bot_move(space) do
      %{
        space: space,
        player: space()[:PLAYER_2]
      }
    end
    test "when board is empty" do
      game_round = Forge.game_round(board: Fixtures.emptyBoard)
      assert Bot.calculate_move(game_round) == bot_move(0)
    end

    test "when player took a space" do
      empty = Fixtures.spaceEmpty
      game_round = Forge.game_round(
        board: [space()[:PLAYER_1], empty, empty,
                empty, empty, empty,
                empty, empty, empty])
      assert Bot.calculate_move(game_round) == bot_move(1)
    end

    test "when player and bot took a spces" do
      empty = Fixtures.spaceEmpty
      game_round = Forge.game_round(
        board: [space()[:PLAYER_1], space()[:PLAYER_2], empty,
                empty, empty, empty,
                empty, empty, empty])
      assert Bot.calculate_move(game_round) == bot_move(2)
    end
  end
end
