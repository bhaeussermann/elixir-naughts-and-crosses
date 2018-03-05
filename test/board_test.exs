defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "create board" do
    assert Board.create(2) == 
      [
        [[position: {0, 0}, value: :empty], [position: {0, 1}, value: :empty]], 
        [[position: {1, 0}, value: :empty], [position: {1, 1}, value: :empty]]
      ]
  end
  
  test "get lines" do
    assert TestHelper.same(Board.get_lines([[1, 2], [3, 4]]), [[1, 2], [3, 4], [1, 3], [2, 4], [1, 4], [2, 3]])
  end
  
  test "get winner" do
    assert Board.get_winner(
      [
        [[position: {0, 0}, value: :naught], [position: {0, 1}, value: :cross], [position: {0, 2}, value: :empty]], 
        [[position: {1, 0}, value: :cross], [position: {1, 1}, value: :cross], [position: {1, 2}, value: :naught]], 
        [[position: {2, 0}, value: :empty], [position: {2, 1}, value: :cross], [position: {2, 2}, value: :naught]]
      ]) == :cross
  end
  
  test "get no winner" do
    assert Board.get_winner(
      [
        [[position: {0, 0}, value: :empty], [position: {0, 1}, value: :cross], [position: {0, 2}, value: :empty]], 
        [[position: {1, 0}, value: :empty], [position: {1, 1}, value: :cross], [position: {1, 2}, value: :naught]], 
        [[position: {2, 0}, value: :empty], [position: {2, 1}, value: :empty], [position: {2, 2}, value: :naught]]
      ]) == :none
  end
  
  test "get tie" do
    assert Board.get_winner(
      [
        [[position: {0, 0}, value: :cross], [position: {0, 1}, value: :cross], [position: {0, 2}, value: :naught]], 
        [[position: {1, 0}, value: :naught], [position: {1, 1}, value: :cross], [position: {1, 2}, value: :cross]], 
        [[position: {2, 0}, value: :cross], [position: {2, 1}, value: :naught], [position: {2, 2}, value: :naught]]
      ]) == :tie
  end
  
  test "get value" do
    assert Board.get_value(
      [
        [[position: {0, 0}, value: :empty], [position: {0, 1}, value: :cross]], 
        [[position: {1, 0}, value: :empty], [position: {1, 1}, value: :empty]]
      ], 0, 1) == :cross
  end
  
  test "set value" do
    assert Board.create(2) |> Board.set_value(0, 1, :cross) ==
      [
        [[position: {0, 0}, value: :empty], [position: {0, 1}, value: :cross]], 
        [[position: {1, 0}, value: :empty], [position: {1, 1}, value: :empty]]
      ]
  end
end
