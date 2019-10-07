defmodule Game do
  def create(game_id, opponent_type) do
    GameRound.start(game_id, opponent_type)
  end

  def make_move_against_bot(round, taken_space) do
    first_player = round.round_setup.first_player
    second_player = round.round_setup.second_player
    board = round.board

    {round_state, board} = Board.apply_move(board, taken_space, first_player.code)
    winner = round_state == :PlayerWon && :PLAYER_1 || nil

    bot_move = Bot.calculate_move(
      round_state,
      board,
      first_player.code,
      second_player.code,
      second_player.type)

    {round_state, board} = Board.apply_move(round_state, board, bot_move, second_player.code)
    winner = (round_state == :PlayerWon && winner == nil) && :PLAYER_2 || winner

    round_state = map_round_state(round_state, winner)
    GameRound.update(round, round_state, board)
  end

  def map_round_state(:Playing, _), do: :PLAYER_1_MOVES
  def map_round_state(:Draw, _), do: :DRAW
  def map_round_state(:PlayerWon, :PLAYER_1), do: :PLAYER_1_WON
  def map_round_state(:PlayerWon, :PLAYER_2), do: :PLAYER_2_WON
end
