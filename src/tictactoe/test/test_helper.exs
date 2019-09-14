ExUnit.start()
Faker.start()

defmodule Fixtures do

  def spaceEmpty, do: Map.fetch(Tictactoe.Enums.space, EMPTY)

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

  # # this will create a user with roles set to [:admin]
  # register :admin,
  #   [prototype: :user],
  #   roles: ["admin"]
end
