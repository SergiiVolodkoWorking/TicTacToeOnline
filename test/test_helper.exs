ExUnit.start()
Faker.start()

defmodule Fixtures do
  alias Tictactoe.Enums, as: Enums

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

  def randomGameState do
    Fixtures.randomEnum(Enums.gameState)
  end

  def randomBoard do
    [
      randomEnum(Enums.spaces), randomEnum(Enums.spaces), randomEnum(Enums.spaces),
      randomEnum(Enums.spaces), randomEnum(Enums.spaces), randomEnum(Enums.spaces),
      randomEnum(Enums.spaces), randomEnum(Enums.spaces), randomEnum(Enums.spaces)
    ]
  end

  def randomSpaceIndexesList(length, list \\ [])
  def randomSpaceIndexesList(0, list), do: list
  def randomSpaceIndexesList(length, list) do
    length - 1
    |> randomSpaceIndexesList([randomSpaceIndex() | list])
  end
end

defmodule Forge do
  use Blacksmith
  alias Tictactoe.Enums, as: Enums

  register :player,
    type: Fixtures.randomEnum(Enums.playerType),
    symbol: Fixtures.randomSymbol(),
    code: Fixtures.randomPlayerSpace()

  register :round_setup,
    first_player: Forge.player(code: :PLAYER_1),
    second_player: Forge.player(code: :PLAYER_2)

  register :round_setup_easy_bot,
    first_player: Forge.player(type: :HUMAN, code: :PLAYER_1),
    second_player: Forge.player(type: :BOT_EASY, code: :PLAYER_2)

  register :game_round,
    game_id: Faker.UUID.v4,
    round_setup: Forge.round_setup,
    round_state: Fixtures.randomEnum(Enums.gameState),
    board: Fixtures.randomBoard()

  register :game_round_vs_easy_bot,
    game_id: Faker.UUID.v4,
    round_setup: Forge.round_setup_easy_bot,
    round_state: :PLAYER_1_MOVES,
    board: Fixtures.randomBoard()
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
