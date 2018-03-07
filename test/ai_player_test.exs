defmodule AiPlayerTest do
  use ExUnit.Case
  doctest AiPlayer
  
  test "get open space count" do
    assert AiPlayer.get_open_space_count(
    [
      [position: {0, 0}, value: :cross], 
      [position: {0, 1}, value: :empty], 
      [position: {0, 2}, value: :cross]
    ], :cross) == 1
  end
  
  test "get not an open space" do
    assert AiPlayer.get_open_space_count(
    [
      [position: {0, 0}, value: :naught], 
      [position: {0, 1}, value: :empty], 
      [position: {0, 2}, value: :empty]
    ], :cross) == :not_open
  end
  
  test "final move" do
    assert AiPlayer.get_move(
    [
      board: [
          [[position: {0, 0}, value: :naught], [position: {0, 1}, value: :naught], [position: {0, 2}, value: :cross]], 
          [[position: {1, 0}, value: :cross], [position: {1, 1}, value: :cross], [position: {1, 2}, value: :naught]], 
          [[position: {2, 0}, value: :naught], [position: {2, 1}, value: :cross], [position: {2, 2}, value: :empty]]
      ],
      current_player: :cross
    ]) == {2, 2}
  end
end
