defmodule GameRound do
  defstruct [:game_id, :round_setup, :round_state, :board]

  def start(game_id) do
    setup = %{
      first_player: %{type: :HUMAN, symbol: "X", code: :PLAYER_1},
      second_player: %{type: :BOT_EASY, symbol: "O", code: :PLAYER_2},
    }
    empty = :EMPTY

    %{
      game_id: game_id,
      round_setup: setup,
      round_state: :PLAYER_1_MOVES,
      board: [empty, empty, empty,
              empty, empty, empty,
              empty, empty, empty]
    }
  end

  def update(round, round_state, board) do
    %{
      game_id: round.game_id,
      round_setup: round.round_setup,
      board: board,
      round_state: round_state
    }
  end
end
