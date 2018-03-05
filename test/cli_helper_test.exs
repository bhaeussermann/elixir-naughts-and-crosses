defmodule CliHelperTest do
  use ExUnit.Case
  doctest CliHelper

  test "board to position-lookup" do
    assert CliHelper.get_position_lookup([[1, 2], [3, 4]])
      == %{ 1 => {0, 0}, 2 => {0, 1}, 3 => {1, 0}, 4 => {1, 1} }
  end
end
