ExUnit.start()

defmodule TestHelper do
  def same([], []) do
    true
  end
  
  def same(actual, []) do
    throw "Actual list contains unexpected elements: #{value_to_string(actual)}"
  end
  
  def same(actual, [expected_first | expected_tail]) do
    same(remove(actual, expected_first), expected_tail)
  end
  
  defp remove([], x) do
    throw "Value #{value_to_string(x)} was not found in list."
  end
  
  defp remove([x | tail], x) do
    tail
  end
  
  defp remove([head | tail], x) do
    [head | remove(x, tail)]
  end
  
  defp value_to_string(list) when is_list(list) do
    "[ #{list_to_string(list)} ]"
  end
  
  defp value_to_string(tuple) when is_tuple(tuple) do
    "{ #{tuple |> Tuple.to_list |> list_to_string} }"
  end
  
  defp value_to_string(x) do
    Kernel.to_string(x)
  end
  
  defp list_to_string([]) do
    ""
  end
  
  defp list_to_string([x]) do
    value_to_string(x)
  end
  
  defp list_to_string([head | tail]) do
    "#{value_to_string(head)}, #{list_to_string(tail)}"
  end
end
