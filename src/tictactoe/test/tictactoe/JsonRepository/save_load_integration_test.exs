defmodule Tictactoe.JsonRepositoryTests do
  use ExUnit.Case
  alias Tictactoe.JsonRepository, as: SUT

  describe "Json Repository save/load integration" do
    test "save map as json file and succesfully " do
      timestamp = DateTime.utc_now()
        |> DateTime.to_unix()
      file_name = "integration-test-file-name-#{timestamp}"
      json_map = %{
        nested: %{
          node: %{atom: :ATOM, text: "X"},
        },
        array: [0,1,2]
      }

      SUT.save(file_name, json_map)

      expected_file_path = "./../../data/#{file_name}.json"
      assert File.exists?(expected_file_path)

      expected = Jason.decode!(Jason.encode!(json_map))
      assert expected == SUT.load(file_name)
    end
  end
end
