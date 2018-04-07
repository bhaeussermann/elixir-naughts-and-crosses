defmodule NaughtsAndCrossesWeb.PageView do
  use NaughtsAndCrossesWeb, :view
  alias NaughtsAndCrosses.Boards
  alias NaughtsAndCrosses.BoardCell
  
  def class_for_cell(cell) do
    case cell.value do
      :naught -> "naught"
      :cross -> "cross"
      :empty -> ""
    end
  end
  
  def position_string(%BoardCell{ position: {row, column} }) do
    "row=#{row}&column=#{column}"
  end
end
