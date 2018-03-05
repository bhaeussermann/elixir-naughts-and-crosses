defmodule ListHelperTest do
  use ExUnit.Case
  doctest ListHelper

  test "set value" do
    assert ListHelper.set_value([1, 2, 3], 1, 0) == [1, 0, 3]
  end

  test "get columns" do
    assert ListHelper.get_columns([[1, 2], [3, 4]]) == [[1, 3], [2, 4]]
  end
  
  test "get diagonal 1" do
    assert ListHelper.get_diagonal_1([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) ==  [1, 5, 9]
  end
  
  test "get diagonal 2" do
    assert ListHelper.get_diagonal_2([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) ==  [3, 5, 7]
  end
end
