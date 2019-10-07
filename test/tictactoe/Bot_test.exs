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

  describe "Hard bot calculate move" do
    test "takes center if possible" do
      player = Fixtures.randomPlayerSpace
      bot = other_player(player)
      board = Fixtures.emptyBoard

      assert Bot.calculate_move(:Playing, board, player, bot, :BOT_HARD) == 4
    end

    test "if center not available takes first winning move" do
      player = Fixtures.randomPlayerSpace
      bot = other_player(player)
      empty = :EMPTY
      board = [
        bot, player, empty,
        player, bot, player,
        empty, empty, empty
      ]
      assert Bot.calculate_move(:Playing, board, player, bot, :BOT_HARD) == 8
    end

    test "if center not available and no winning moves blocks first winning move of opponent" do
      player = Fixtures.randomPlayerSpace
      bot = other_player(player)
      empty = :EMPTY
      board = [
        player, empty, empty,
        player, bot, bot,
        empty, empty, empty
      ]
      assert Bot.calculate_move(:Playing, board, player, bot, :BOT_HARD) == 6
    end

    test "otherwise returns a random move" do
      player = Fixtures.randomPlayerSpace
      bot = other_player(player)
      empty = :EMPTY
      board = [
        player, empty, empty,
        empty, bot, empty,
        empty, empty, empty
      ]
      assert Bot.calculate_move(:Playing, board, player, bot, :BOT_HARD) == 1
    end
  end

  def other_player(:PLAYER_1), do: :PLAYER_2
  def other_player(:PLAYER_2), do: :PLAYER_1
end
