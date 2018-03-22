defmodule NaughtsAndCrosses.ListHelper do
  def set_value([_ | tail], 0, new_value) do
    [new_value | tail]
  end
  
  def set_value([head | tail], index, new_value) do
    [head | set_value(tail, index - 1, new_value)]
  end

  def get_columns([[] | _]) do
    []
  end
  
  def get_columns(list) do
    [get_first_column(list) | get_columns(get_row_tails(list))]
  end
  
  def get_diagonal_1([]) do
    []
  end
  
  def get_diagonal_1([[first_value | _] | tail]) do
    [first_value | get_diagonal_1(get_row_tails(tail))]
  end
  
  def get_diagonal_2(list) do
    list |> Enum.reverse |> get_diagonal_1 |> Enum.reverse
  end
  
  defp get_first_column([]) do
    []
  end
  
  defp get_first_column([[first_value | _] | tail]) do
    [first_value | get_first_column(tail)]
  end
  
  defp get_row_tails([]) do
    []
  end
  
  defp get_row_tails([[_ | first_row_tail] | tail]) do
    [first_row_tail | get_row_tails(tail)]
  end
end
