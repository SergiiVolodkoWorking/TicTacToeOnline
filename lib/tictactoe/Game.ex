defmodule Game do
  def create(game_id) do
    GameRound.start(game_id)
  end

  def make_move_against_bot(round, taken_space) do
    first_player = round.round_setup.first_player
    second_player = round.round_setup.second_player
    board = round.board

    #{code: PLAYER_1}?
    {roundState, board} = Board.apply_move(board, taken_space, first_player.symbol)
    bot_move = Bot.calculate_move(roundState, board, first_player, second_player)
    {roundState, board} = Board.apply_move(roundState, board, bot_move, second_player.symbol)

    GameRound.update(round, roundState, board)
  end
end

defmodule Bot do
  def calculate_move(:PlayerWon, _, _, _), do: nil
  def calculate_move(:Draw, _, _, _), do: nil

  def calculate_move(:Playing, board, _, _, :BOT_EASY) do
    Board.available_spaces(board)
    |> BotIntellect.random_move
  end

  # def calculate_move(:Playing, board, opponent_player, bot_player, :BOT_HARD) do
  #   available_spaces = Board.available_spaces(board)
  #   move = BotIntellect.take_center(available_spaces)
  #   move = BotIntellect.get_winning_move(move, available_spaces, bot_player, board)
  #   move = BotIntellect.get_winning_move(move, available_spaces, opponent_player, board)
  #   move = BotIntellect.random_move(move, available_spaces)
  #   move
  # end
end

defmodule BotIntellect do
  def random_move(available_spaces), do: List.first(available_spaces)
  def random_move(nil, available_spaces), do: List.first(available_spaces)
  def random_move(move, _), do: move

  def take_center(available_spaces), do: Enum.find(available_spaces, fn s -> s == 4 end)

  def get_winning_move(move, _, _, _), do: move
  def get_winning_move(nil, available_spaces, player, board) do
    boardModel = board#clone?

    Enum.find(available_spaces, fn s -> Board.apply_move(boardModel, s, player.symbol) == :PlayerWon end)
  end
end


defmodule Board do
  def available_spaces(board) do
    ListHelper.find_indexes(board, fn s -> s == :EMPTY end)
  end

  def apply_move(board, move_space, symbol) do
    board = List.replace_at(board, move_space, symbol)

    has_player_won = Tictactoe.Rules.has_player_won(board, symbol)
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

defmodule Tictactoe.Rules do
  def is_draw(board) do
    !Enum.member?(board, :EMPTY)
  end

  def has_player_won(board, player) do
    # Horizontal
    (Enum.at(board, 0) == player && Enum.at(board, 1) == player && Enum.at(board, 2) == player) ||
    (Enum.at(board, 3) == player && Enum.at(board, 4) == player && Enum.at(board, 5) == player) ||
    (Enum.at(board, 6) == player && Enum.at(board, 7) == player && Enum.at(board, 8) == player) ||

    # Vertical
    (Enum.at(board, 0) == player && Enum.at(board, 3) == player && Enum.at(board, 6) == player) ||
    (Enum.at(board, 1) == player && Enum.at(board, 4) == player && Enum.at(board, 7) == player) ||
    (Enum.at(board, 2) == player && Enum.at(board, 5) == player && Enum.at(board, 8) == player) ||

    # Diagonals
    (Enum.at(board, 0) == player && Enum.at(board, 4) == player && Enum.at(board, 8) == player) ||
    (Enum.at(board, 2) == player && Enum.at(board, 4) == player && Enum.at(board, 6) == player)
  end
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
