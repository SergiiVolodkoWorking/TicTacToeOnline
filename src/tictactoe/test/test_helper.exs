ExUnit.start()
Faker.start()

defmodule Fixtures do

  def spaceEmpty do
    Tictactoe.Enums.space[:EMPTY]
  end

  def randomPlayerSpace do
    x = :rand.uniform(2)
    cond do
      x == 1 -> Tictactoe.Enums.space[:PLAYER_1]
      x == 2 -> Tictactoe.Enums.space[:PLAYER_2]
    end
  end

  def randomSpaceIndex do
    :rand.uniform(9) - 1
  end

  def emptyBoard do
    empty = Tictactoe.Enums.space[:EMPTY]
    [empty, empty, empty,
    empty, empty, empty,
    empty, empty, empty]
  end

  def randomSymbol() do
    x = :rand.uniform(255)
    List.to_string([x])
  end

  def randomEnum(enum) do
    elem(hd(Enum.take_random(enum, 1)),1)
  end
end

defmodule Forge do
  use Blacksmith

  register :player,
    type: Fixtures.randomEnum(Tictactoe.Enums.playerType),
    symbol: Fixtures.randomSymbol()

  register :round_setup,
    first_player: Forge.player,
    second_player: Forge.player

  register :game_round,
    game_id: Faker.UUID.v4,
    round_setup: Forge.round_setup,
    round_state: Fixtures.randomEnum(Tictactoe.Enums.gameState),
    board: [
      Fixtures.randomEnum(Tictactoe.Enums.space), Fixtures.randomEnum(Tictactoe.Enums.space), Fixtures.randomEnum(Tictactoe.Enums.space),
      Fixtures.randomEnum(Tictactoe.Enums.space), Fixtures.randomEnum(Tictactoe.Enums.space), Fixtures.randomEnum(Tictactoe.Enums.space),
      Fixtures.randomEnum(Tictactoe.Enums.space), Fixtures.randomEnum(Tictactoe.Enums.space), Fixtures.randomEnum(Tictactoe.Enums.space)]
end
