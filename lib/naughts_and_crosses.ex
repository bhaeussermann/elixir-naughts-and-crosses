defmodule NaughtsAndCrosses do
  def main(_) do
    player_move_functions = 
      if prompt_human_player() == :naught do
        [naught: &HumanPlayer.get_move/1, cross: &AiPlayer.get_move/1]
      else
        [naught: &AiPlayer.get_move/1, cross: &HumanPlayer.get_move/1]
      end
    
    keys = [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"]]
    key_position_lookup = CliHelper.get_position_lookup(keys)
    
    IO.puts("=== Naughts & Crosses ===\r\n")
    IO.puts("Type one of the following to place at the corresponding position ('q' to quit):\r\n")
    print_board(keys, &Kernel.to_string/1)
    
    play([
      board: Board.create(3), 
      current_player: :naught, 
      player_move_functions: player_move_functions, 
      key_position_lookup: key_position_lookup
    ])
  end
  
  defp prompt_human_player do
    case IO.gets("Choose your piece: o/x ") |> String.trim do
      "o" -> :naught
      "x" -> :cross
      _ -> prompt_human_player()
    end
  end
  
  defp play(state) do
    board = state[:board]
    IO.puts("")
    print_board(board)
    
    case Board.get_winner(board) do
      :naught -> IO.puts("Naughts is the winner!")
      :cross -> IO.puts("Cross is the winner!")
      :tie -> IO.puts("It's a tie.")
      :none -> next_move(state)
    end
  end
  
  defp next_move(state) do
    player_move_function = state[:player_move_functions][state[:current_player]]
    case player_move_function.(state) do
      :halt -> :halt
      move -> move |> apply_move(state) |> play()
    end
  end
  
  defp apply_move({row, column}, state) do
    board = state[:board]
    current_player = state[:current_player]
    [
      board: Board.set_value(board, row, column, current_player), 
      current_player: (if current_player == :naught, do: :cross, else: :naught), 
      player_move_functions: state[:player_move_functions], 
      key_position_lookup: state[:key_position_lookup]
    ]
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
