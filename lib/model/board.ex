defmodule Board do
  def create(size) do
    create_board(0, size)
  end
  
  def get_value(board, row, column) do
    board |> Enum.at(row) |> Enum.at(column) |> Map.get(:value)
  end
  
  def set_value(board, row, column, new_value) do
    updated_row = board |> Enum.at(row) |> ListHelper.set_value(column, %BoardCell{position: { row, column }, value: new_value})
    ListHelper.set_value(board, row, updated_row)
  end
  
  def get_lines(board) do
    board ++ ListHelper.get_columns(board) ++ [ListHelper.get_diagonal_1(board), ListHelper.get_diagonal_2(board)]
  end
  
  def get_winner(board) do
    board 
    |> get_lines 
    |> Enum.map(&(get_line_winner(&1))) 
    |> Enum.reduce(&(if &1 in [:naught, :cross], do: &1, else: if &2 == :tie, do: &1, else: &2))
  end
  
  defp create_board(size, size) do
    []
  end
  
  defp create_board(current_row, size) do
    [create_row(current_row, 0, size) | create_board(current_row + 1, size)]
  end
  
  defp create_row(_, upper_column, upper_column) do
    []
  end
  
  defp create_row(current_row, current_column, upper_column) do
    [%BoardCell{position: {current_row, current_column}} | create_row(current_row, current_column + 1, upper_column)]
  end
  
  defp get_line_winner([%BoardCell{value: :empty} | _]) do
    :none
  end
  
  defp get_line_winner([head | tail]) do
    cond do
      Enum.all?(tail, &(&1.value == head.value)) -> head.value
      Enum.all?(tail, &(&1.value != :empty)) -> :tie
      true -> :none
    end
  end
end
