defmodule HumanPlayer do
  def get_move(state) do
    move = IO.gets("\r\n#{if state[:current_player] == :naught, do: "Naught's", else: "Cross'"} turn to move: ") 
      |> String.trim
    
    if move != "q" do
      key_position_lookup = state[:key_position_lookup]
      case Map.fetch(key_position_lookup, move) do
        {:ok, position} -> validate_move(state, position)
        :error -> report_input_error(state)
      end
    else
      :halt
    end
  end
  
  defp validate_move(state, {row, column}) do
    if Board.get_value(state[:board], row, column) == :empty do
      {row, column}
    else
      IO.puts("The specified cell is occupied.")
      get_move(state)
    end
  end
  
  defp report_input_error(state) do
    IO.puts("Invalid input.")
    get_move(state)
  end
end
