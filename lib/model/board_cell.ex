defmodule BoardCell do
  @enforce_keys [:position]
  defstruct position: nil, value: :empty
end
