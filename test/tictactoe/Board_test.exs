defmodule BoardTests do
  use ExUnit.Case

  describe "available spaces" do
    test "returns empty list if there are no Empty spaces" do
      board = [:NotEmpty, :NotEmpty]

      assert Board.available_spaces(board) == []
    end

    test "returns list of indexes of all empty spaces" do
      board = [:NotEmpty, :NotEmpty, :EMPTY, :EMPTY, :NotEmpty]

      assert Board.available_spaces(board) == [2, 3]
    end
  end

  describe "move result gives" do
    test "victory result if player has won" do
      board = Fixtures.randomBoard()
      has_player_won = true

      assert Board.move_result(has_player_won, board) == {:PlayerWon, board}
    end

    test "game continuation result if player didn't win" do
      board = Fixtures.randomBoard()
      has_player_won = false

      assert Board.move_result(has_player_won, board) == {:Playing, board}
    end

    test "draw result if player didn't win but there is a draw" do
      board = Fixtures.randomBoard()
      is_draw = true

      assert Board.move_result(:Playing, is_draw, board) == {:Draw, board}
    end

    test "game continuation result when player didn't win and there is no draw" do
      board = Fixtures.randomBoard()
      is_draw = false

      assert Board.move_result(:Playing, is_draw, board) == {:Playing, board}
    end
  end

  describe "apply move" do
    test "empty board gets updated and round continues" do
      board = Fixtures.emptyBoard
      move = Fixtures.randomSpaceIndex
      player = Fixtures.randomPlayerSpace

      expectedBoard = List.replace_at(board, move, player)

      assert Board.apply_move(board, move, player) == {:Playing, expectedBoard}
      assert Board.apply_move(:Playing, board, move, player) == {:Playing, expectedBoard}
    end

    test "applying a winning move gives a victory result" do
      empty = :EMPTY
      player = Fixtures.randomPlayerSpace
      board = [player, player, empty,
                empty, empty, empty,
                empty, empty, empty]
      move = 2
      expectedBoard = List.replace_at(board, move, player)

      assert Board.apply_move(board, move, player) == {:PlayerWon, expectedBoard}
      assert Board.apply_move(:Playing, board, move, player) == {:PlayerWon, expectedBoard}
    end

    test "applying a draw move gives a draw result" do
      empty = :EMPTY
      x = Fixtures.randomPlayerSpace()
      o = other_player(x)
      board = [x, x, o,
              o, x, empty,
              x, o, o]
      move = 5
      expectedBoard = List.replace_at(board, move, x)

      assert Board.apply_move(board, move, x) == {:Draw, expectedBoard}
      assert Board.apply_move(:Playing, board, move, x) == {:Draw, expectedBoard}
    end

    test "does nothing if there is already a draw present" do
      board = Fixtures.randomBoard()
      player = Fixtures.randomPlayerSpace
      move = Fixtures.randomSpaceIndex

      assert Board.apply_move(:Draw, board, move, player) == {:Draw, board}
    end

    test "does nothing if there is already a victory present" do
      board = Fixtures.randomBoard()
      player = Fixtures.randomPlayerSpace
      move = Fixtures.randomSpaceIndex

      assert Board.apply_move(:PlayerWon, board, move, player) == {:PlayerWon, board}
    end
  end

  def other_player(:PLAYER_1), do: :PLAYER_2
  def other_player(:PLAYER_2), do: :PLAYER_1
end
