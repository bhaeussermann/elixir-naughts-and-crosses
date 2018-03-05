defmodule NaughtsAndCrosses do
  def main(_) do
    keys = [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"]]
    key_position_lookup = CliHelper.get_position_lookup(keys)
    
    IO.puts("=== Naughts & Crosses ===\r\n")
    IO.puts("Type one of the following to place at the corresponding position ('q' to quit):\r\n")
    print_board(keys, &Kernel.to_string/1)
    
    play([board: Board.create(3), current_player: :naught, key_position_lookup: key_position_lookup])
  end
  
  defp play(state) do
    board = state[:board]
    IO.puts("")
    print_board(board)
    
    case Board.get_winner(board) do
      :naught -> IO.puts("Naughts is the winner!")
      :cross -> IO.puts("Cross is the winner!")
      :tie -> IO.puts("It's a tie.")
      :none -> read_move(state)
    end
  end
  
  defp read_move(state) do
    move = IO.gets("\r\n#{if state[:current_player] == :naught, do: "Naught's", else: "Cross'"} turn to move: ") 
      |> String.trim
    
    if move != "q" do
      key_position_lookup = state[:key_position_lookup]
      case Map.fetch(key_position_lookup, move) do
        {:ok, {row, column}} -> move(state, row, column)
        :error -> report_input_error(state)
      end
    end
  end
  
  defp move(state, row, column) do
    board = state[:board]
    current_player = state[:current_player]
    
    if Board.get_value(board, row, column) == :empty do
      board = Board.set_value(board, row, column, current_player)
      next_player = if current_player == :naught, do: :cross, else: :naught
      play([board: board, current_player: next_player, key_position_lookup: state[:key_position_lookup]])
    else
      IO.puts("The specified cell is occupied.")
      play(state)
    end
  end
  
  defp report_input_error(state) do
    IO.puts("Invalid input.")
    play(state)
  end
  
  defp print_board(board) do
    print_board(board, &get_board_cell_character/1)
  end
  
  defp print_board([], _) do
  end
  
  defp print_board([first_row | tail], get_cell_character) do
    print_board_row(first_row, get_cell_character)
    print_board(tail, get_cell_character)
  end
  
  defp print_board_row([cell], get_cell_character) do
    cell |> get_cell_character.() |> IO.puts
  end
  
  defp print_board_row([cell | tail], get_cell_character) do
    cell |> get_cell_character.() |> IO.write
    IO.write("|")
    print_board_row(tail, get_cell_character)
  end
  
  defp get_board_cell_character([position: _, value: value]) do
    case value do
      :empty -> " "
      :naught -> "o"
      :cross -> "x"
    end
  end
end
