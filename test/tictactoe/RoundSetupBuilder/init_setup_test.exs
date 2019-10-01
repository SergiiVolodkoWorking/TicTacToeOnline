defmodule Tictactoe.RoundSetupBuilderTest do
  use ExUnit.Case
  alias Tictactoe.RoundSetupBuilder, as: Builder

  describe "when init_setup is called" do
    test "it creates initial round setup" do
      expected =
      %{
        first_player: %{type: :HUMAN, symbol: "X"},
        second_player: %{type: :BOT_EASY, symbol: "O"},
      }
      assert expected == Builder.init_setup()
    end
  end
end
