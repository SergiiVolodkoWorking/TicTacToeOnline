defmodule Tictactoe.RulesTests do
  use ExUnit.Case
  describe "The draw" do
    test "is the situation when there no empty spaces on the board" do
      board = [:PLAYER_1, :PLAYER_2, :PLAYER_1,
               :PLAYER_2, :PLAYER_1, :PLAYER_2,
               :PLAYER_2, :PLAYER_1, :PLAYER_2]

      assert Tictactoe.Rules.is_draw(board) == true
    end

    test "if there is at least one not empty space it is not a draw" do
      board = [:PLAYER_1, :PLAYER_2, :EMPTY,
               :PLAYER_2, :PLAYER_1, :PLAYER_2,
               :PLAYER_2, :PLAYER_1, :PLAYER_2]

      assert Tictactoe.Rules.is_draw(board) == false
    end
  end

  describe "Player wins if he takes" do
    test "1st horizontal line" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [x,x,x,
              empty, empty, empty,
              empty, empty, empty]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end

    test "2nd horizontal line" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [empty, empty, empty,
              x,x,x,
              empty, empty, empty]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end

    test "3rd horizontal line" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [empty, empty, empty,
              empty, empty, empty,
              x,x,x]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end

    test "1st vertical line" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [x, empty, empty,
              x, empty, empty,
              x, empty, empty]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end

    test "2nd vertical line" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [empty, x, empty,
               empty, x, empty,
               empty, x, empty]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end

    test "3rd vertical line" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [empty, empty, x,
               empty, empty, x,
               empty, empty, x]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end

    test "1st diagonal" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [x, empty, empty,
              empty, x, empty,
              empty, empty, x]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end

    test "2nd diagonal" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace
      board = [empty, empty, x,
              empty, x, empty,
              x, empty, empty]

      assert Tictactoe.Rules.has_player_won(board, x) == true
    end
  end

  describe "Player doesn't win when" do
    test "board is still empty" do
      x = Fixtures.randomPlayerSpace
      board = Fixtures.emptyBoard

      assert Tictactoe.Rules.has_player_won(board, x) == false
    end

    test "they didn't finish a line or diagonal" do
      empty = :EMPTY
      x = :PLAYER_1
      o = :PLAYER_2
      board = [x,x,o,
               x,empty,o,
               empty, empty, x]

      assert Tictactoe.Rules.has_player_won(board, x) == false
      assert Tictactoe.Rules.has_player_won(board, o) == false
    end
  end
end
