defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "create board" do
    assert Board.create(2) == 
      [
        [%BoardCell{position: {0, 0}, value: :empty}, %BoardCell{position: {0, 1}, value: :empty}], 
        [%BoardCell{position: {1, 0}, value: :empty}, %BoardCell{position: {1, 1}, value: :empty}]
      ]
  end
  
  test "get lines" do
    assert TestHelper.same(
      Board.get_lines([[1, 2], [3, 4]]), 
      [[1, 2], [3, 4], [1, 3], [2, 4], [1, 4], [2, 3]])
  end
  
  test "get winner" do
    assert Board.get_winner(
      [
        [%BoardCell{position: {0, 0}, value: :naught}, %BoardCell{position: {0, 1}, value: :cross}, %BoardCell{position: {0, 2}, value: :empty}], 
        [%BoardCell{position: {1, 0}, value: :cross}, %BoardCell{position: {1, 1}, value: :cross}, %BoardCell{position: {1, 2}, value: :naught}], 
        [%BoardCell{position: {2, 0}, value: :empty}, %BoardCell{position: {2, 1}, value: :cross}, %BoardCell{position: {2, 2}, value: :naught}]
      ]) == :cross
  end
  
  test "get no winner" do
    assert Board.get_winner(
      [
        [%BoardCell{position: {0, 0}, value: :empty}, %BoardCell{position: {0, 1}, value: :cross}, %BoardCell{position: {0, 2}, value: :empty}], 
        [%BoardCell{position: {1, 0}, value: :empty}, %BoardCell{position: {1, 1}, value: :cross}, %BoardCell{position: {1, 2}, value: :naught}], 
        [%BoardCell{position: {2, 0}, value: :empty}, %BoardCell{position: {2, 1}, value: :empty}, %BoardCell{position: {2, 2}, value: :naught}]
      ]) == :none
  end
  
  test "get tie" do
    assert Board.get_winner(
      [
        [%BoardCell{position: {0, 0}, value: :cross}, %BoardCell{position: {0, 1}, value: :cross}, %BoardCell{position: {0, 2}, value: :naught}], 
        [%BoardCell{position: {1, 0}, value: :naught}, %BoardCell{position: {1, 1}, value: :cross}, %BoardCell{position: {1, 2}, value: :cross}], 
        [%BoardCell{position: {2, 0}, value: :cross}, %BoardCell{position: {2, 1}, value: :naught}, %BoardCell{position: {2, 2}, value: :naught}]
      ]) == :tie
  end
  
  test "get value" do
    assert Board.get_value(
      [
        [%BoardCell{position: {0, 0}, value: :empty}, %BoardCell{position: {0, 1}, value: :cross}], 
        [%BoardCell{position: {1, 0}, value: :empty}, %BoardCell{position: {1, 1}, value: :empty}]
      ], 0, 1) == :cross
  end
  
  test "set value" do
    assert Board.create(2) |> Board.set_value(0, 1, :cross) ==
      [
        [%BoardCell{position: {0, 0}, value: :empty}, %BoardCell{position: {0, 1}, value: :cross}], 
        [%BoardCell{position: {1, 0}, value: :empty}, %BoardCell{position: {1, 1}, value: :empty}]
      ]
  end
end
