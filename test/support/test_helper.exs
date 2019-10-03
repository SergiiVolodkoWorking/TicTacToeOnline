ExUnit.start()
Faker.start()

defmodule Fixtures do

  def spaceEmpty do
    :EMPTY
  end

  def randomPlayerSpace do
    x = :rand.uniform(2)
    cond do
      x == 1 -> :PLAYER_1
      x == 2 -> :PLAYER_2
    end
  end

  def randomSpaceIndex do
    :rand.uniform(9) - 1
  end

  def emptyBoard do
    empty = :EMPTY
    [empty, empty, empty,
    empty, empty, empty,
    empty, empty, empty]
  end

  def randomSymbol() do
    x = :rand.uniform(255)
    List.to_string([x])
  end

  def randomEnum(enum) do
    [item] = Enum.take_random(enum, 1)
    item
  end
end

defmodule Forge do
  use Blacksmith
  alias Tictactoe.Enums, as: Enums

  register :player,
    type: Fixtures.randomEnum(Enums.playerType),
    symbol: Fixtures.randomSymbol()

  register :round_setup,
    first_player: Forge.player,
    second_player: Forge.player

  register :game_round,
    game_id: Faker.UUID.v4,
    round_setup: Forge.round_setup,
    round_state: Fixtures.randomEnum(Enums.gameState),
    board: [
      Fixtures.randomEnum(Enums.spaces), Fixtures.randomEnum(Enums.spaces), Fixtures.randomEnum(Enums.spaces),
      Fixtures.randomEnum(Enums.spaces), Fixtures.randomEnum(Enums.spaces), Fixtures.randomEnum(Enums.spaces),
      Fixtures.randomEnum(Enums.spaces), Fixtures.randomEnum(Enums.spaces), Fixtures.randomEnum(Enums.spaces)]
end

defmodule Tictactoe.Enums do
  def spaces do [:EMPTY, :PLAYER_1, :PLAYER_2] end

  def gameState do [
    :NOT_STARTED,
    :PLAYER_1_MOVES,
    :PLAYER_2_MOVES,
    :PLAYER_1_WON,
    :PLAYER_2_WON,
    :DRAW
  ]
  end

  def playerType do [:HUMAN, :BOT_EASY] end
end



Mox.defmock(Tictactoe.RoundSetupBuilderImplMock, for: Tictactoe.RoundSetupBuilder)
