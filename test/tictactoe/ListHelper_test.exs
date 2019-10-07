defmodule ListHelperTests do
  use ExUnit.Case

  describe "find indexes" do
    test "returns empty list if nothing found" do
      list = [1, 2, 3]

      assert ListHelper.find_indexes(list, fn s -> s == 'not in list' end) == []
    end

    test "returns list of one index if only one match" do
      list = ['one', 'match']

      assert ListHelper.find_indexes(list, fn s -> s == 'match' end) == [1]
    end

    test "returns list of all index of matching elements" do
      list = [:MATCH, 'one', 2, :MATCH]

      assert ListHelper.find_indexes(list, fn s -> s == :MATCH end) == [0, 3]
    end
  end
end
