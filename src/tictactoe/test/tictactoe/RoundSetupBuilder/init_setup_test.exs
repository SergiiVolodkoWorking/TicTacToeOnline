defmodule Tictactoe.RoundSetupBuilderTest do
  use ExUnit.Case
  alias Tictactoe.RoundSetupBuilder, as: SUT

  #@Some_module Application.get_env(:app, :key)

  describe "when init_setup is called" do
    test "it creates initial round setup" do
      expected =
      %{
        first_player: %{type: :HUMAN, symbol: "X"},
        second_player: %{type: :BOT_EASY, symbol: "O"},
      }

      assert expected == SUT.init_setup()
    end
  end
end
