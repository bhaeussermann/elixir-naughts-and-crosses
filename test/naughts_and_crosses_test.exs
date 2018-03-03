defmodule NaughtsAndCrossesTest do
  use ExUnit.Case
  doctest NaughtsAndCrosses

  test "greets the world" do
    assert NaughtsAndCrosses.hello() == :world
  end
end
