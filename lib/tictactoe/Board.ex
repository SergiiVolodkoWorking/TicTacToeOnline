defmodule Board do
  def available_spaces(board) do
    find_indexes(board, fn s -> s == :EMPTY end)
  end

  def apply_move(:PlayerWon, board, _, _), do: {:PlayerWon, board}
  def apply_move(:Draw, board, _, _), do: {:Draw, board}
  def apply_move(:Playing, board, move_space, player), do: apply_move(board, move_space, player)
  def apply_move(board, move_space, player) do
    board = List.replace_at(board, move_space, player)

    has_player_won = Tictactoe.Rules.has_player_won(board, player)
    {round_state, board} = move_result(has_player_won, board)

    is_draw = Tictactoe.Rules.is_draw(board)
    move_result(round_state, is_draw, board)
  end

  def move_result(true, board), do: {:PlayerWon, board}
  def move_result(false, board), do: {:Playing, board}
  def move_result(:PlayerWon, _, board), do: {:PlayerWon, board}
  def move_result(:Playing, true, board), do: {:Draw, board}
  def move_result(:Playing, false, board), do: {:Playing, board}

  defp find_indexes(collection, condition) do
    collection
    |> Enum.with_index()
    |> Enum.map(fn ({val, idx}) ->
        if condition.(val) do
          idx
        else
          nil
        end
      end)
    |> Enum.reject(&is_nil/1)
  end
end
