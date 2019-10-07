defmodule Board do
  def available_spaces(board) do
    ListHelper.find_indexes(board, fn s -> s == :EMPTY end)
  end

  def apply_move(:PlayerWon, board, _, _), do: {:PlayerWon, board}
  def apply_move(:Draw, board, _, _), do: {:Draw, board}

  def apply_move(:Playing, board, move_space, player), do: apply_move(board, move_space, player)
  def apply_move(board, move_space, player) do
    board = List.replace_at(board, move_space, player)

    has_player_won = Tictactoe.Rules.has_player_won(board, player)
    {round_state, board} = return_round_state(has_player_won, board)

    is_draw = Tictactoe.Rules.is_draw(board)
    return_round_state(round_state, is_draw, board)
  end

  def return_round_state(true, board), do: {:PlayerWon, board}
  def return_round_state(false, board), do: {:Playing, board}
  def return_round_state(:PlayerWon, _, board), do: {:PlayerWon, board}
  def return_round_state(:Playing, true, board), do: {:Draw, board}
  def return_round_state(:Playing, false, board), do: {:Playing, board}
end



defmodule ListHelper do
  def find_indexes(collection, function) do
    do_find_indexes(collection, function, 0, [])
  end

  def do_find_indexes([], _function, _counter, acc) do
    Enum.reverse(acc)
  end

  def do_find_indexes([h|t], function, counter, acc) do
    if function.(h) do
      do_find_indexes(t, function, counter + 1, [counter|acc])
    else
      do_find_indexes(t, function, counter + 1, acc)
    end
  end
end
