defmodule Tictactoe.RoundSetupBuilder do
  import Tictactoe.Enums

  @callback init_setup() :: Map

  def init_setup() do
    %{
      first_player: %{type: playerType()[:HUMAN], symbol: "X"},
      second_player: %{type: playerType()[:BOT_EASY], symbol: "O"},
    }
  end
end
