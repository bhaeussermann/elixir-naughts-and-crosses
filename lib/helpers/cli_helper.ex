defmodule CliHelper do
  def get_position_lookup(list) do
    get_position_lookup(list, 0)
  end
  
  defp get_position_lookup([], _) do
    %{}
  end
  
  defp get_position_lookup([first_row | tail], current_row) do
    tail
      |> get_position_lookup(current_row + 1)
      |> Map.merge(get_position_lookup_row(first_row, current_row, 0))
  end
  
  defp get_position_lookup_row([], _, _) do
    %{}
  end
  
  defp get_position_lookup_row([head | tail], current_row, current_column) do
    tail 
      |> get_position_lookup_row(current_row, current_column + 1)
      |> Map.put(head, {current_row, current_column})
  end
end
