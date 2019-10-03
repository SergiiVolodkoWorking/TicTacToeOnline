defmodule Tictactoe.RoundSetupBuilder do
  @callback init_setup() :: Map
end

defmodule Tictactoe.RoundSetupBuilderImpl do
  @behaviour Tictactoe.RoundSetupBuilder
  def init_setup() do
    %{
      first_player: %{type: :HUMAN, symbol: "X"},
      second_player: %{type: :BOT_EASY, symbol: "O"},
    }
  end
end
