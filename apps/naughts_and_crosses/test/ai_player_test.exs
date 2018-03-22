defmodule NaughtsAndCrosses.AiPlayerTest do
  use ExUnit.Case
  alias NaughtsAndCrosses.AiPlayer
  alias NaughtsAndCrosses.GameState
  alias NaughtsAndCrosses.BoardCell
  doctest AiPlayer
  
  test "get open space count" do
    assert AiPlayer.get_open_space_count(
    [
      %BoardCell{position: {0, 0}, value: :cross}, 
      %BoardCell{position: {0, 1}, value: :empty}, 
      %BoardCell{position: {0, 2}, value: :cross}
    ], :cross) == 1
  end
  
  test "get not an open space" do
    assert AiPlayer.get_open_space_count(
    [
      %BoardCell{position: {0, 0}, value: :naught}, 
      %BoardCell{position: {0, 1}, value: :empty}, 
      %BoardCell{position: {0, 2}, value: :empty}
    ], :cross) == :not_open
  end
  
  test "final move" do
    assert AiPlayer.get_move(
    %GameState{
      board: [
          [%BoardCell{position: {0, 0}, value: :naught}, %BoardCell{position: {0, 1}, value: :naught}, %BoardCell{position: {0, 2}, value: :cross}], 
          [%BoardCell{position: {1, 0}, value: :cross}, %BoardCell{position: {1, 1}, value: :cross}, %BoardCell{position: {1, 2}, value: :naught}], 
          [%BoardCell{position: {2, 0}, value: :naught}, %BoardCell{position: {2, 1}, value: :cross}, %BoardCell{position: {2, 2}, value: :empty}]
      ],
      current_player: :cross
    }) == {2, 2}
  end
end
