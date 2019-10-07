defmodule BotIntellectTests do
  use ExUnit.Case

  describe "Random move" do
    test "picks first avbailable space" do
      available_spaces = [42, 1, 2]

      assert BotIntellect.random_move(available_spaces) == 42
      assert BotIntellect.random_move(nil, available_spaces) == 42
    end

    test "if move was made previously returns that move" do
      available_spaces = Fixtures.randomSpaceIndexesList(9)
      move = Fixtures.randomSpaceIndex

      assert BotIntellect.random_move(move, available_spaces) == move
    end
  end

  describe "Take center" do
    test "if center is available returns it" do
      available_spaces = [1, 2, 4]

      assert BotIntellect.take_center(available_spaces) == 4
    end

    test "if not returns nil" do
      available_spaces = [1, 2, 42]

      assert BotIntellect.take_center(available_spaces) == nil
    end
  end

  describe "Get winning move" do
    test "Returns first available move that will bring victory to the player" do
      empty = :EMPTY
      player = Fixtures.randomPlayerSpace
      board = [player, empty, empty,
              empty, player, player,
              empty, empty, empty]
      available_spaces = [0, 1, 2, 3, 6]

      assert BotIntellect.get_winning_move(nil, available_spaces, player, board) == 3
      assert BotIntellect.get_winning_move(available_spaces, player, board) == 3
    end

    test "if move was made previously returns that move" do
      available_spaces = Fixtures.randomSpaceIndexesList(9)
      player = Fixtures.randomPlayerSpace
      board = Fixtures.randomBoard
      move = Fixtures.randomSpaceIndex

      assert BotIntellect.get_winning_move(move, available_spaces, player, board) == move
    end
  end
end
