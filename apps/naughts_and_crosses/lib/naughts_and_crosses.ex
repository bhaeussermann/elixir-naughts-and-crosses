defmodule NaughtsAndCrosses do
  alias NaughtsAndCrosses.CliHelper
  alias NaughtsAndCrosses.AiPlayer
  alias NaughtsAndCrosses.HumanPlayer
  alias NaughtsAndCrosses.GameState
  alias NaughtsAndCrosses.Board
  alias NaughtsAndCrosses.BoardCell

  def main(_) do
    IO.puts("=== Naughts & Crosses ===\r\n")
    
    board_size = prompt_board_size()
  
    player_move_functions = 
      if prompt_human_player_piece() == :naught do
        [naught: &HumanPlayer.get_move/1, cross: &AiPlayer.get_move/1]
      else
        [naught: &AiPlayer.get_move/1, cross: &HumanPlayer.get_move/1]
      end
    
    keys = if board_size == 3 do
        [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"]]
      else
        [["7", "8", "9", "0"], ["u", "i", "o", "p"], ["j", "k", "l", ";"], ["m", ",", ".", "/"]]
      end
    key_position_lookup = CliHelper.get_position_lookup(keys)
    
    IO.puts("Type one of the following to place at the corresponding position ('q' to quit):\r\n")
    print_board(keys, &Kernel.to_string/1)
    
    play(%GameState{
      board: Board.create(board_size), 
      player_move_functions: player_move_functions, 
      key_position_lookup: key_position_lookup
    })
  end
  
  defp prompt_board_size do
    size = IO.gets("Choose board size: 3/4 ") |> String.trim
    if Enum.member?(["3", "4"], size), do: String.to_integer(size), else: prompt_board_size()
  end
  
  defp prompt_human_player_piece do
    case IO.gets("Choose your piece: o/x ") |> String.trim do
      "o" -> :naught
      "x" -> :cross
      _ -> prompt_human_player_piece()
    end
  end
  
  defp play(state) do
    IO.puts("")
    print_board(state.board)
    
    case Board.get_winner(state.board) do
      :naught -> IO.puts("Naughts is the winner!")
      :cross -> IO.puts("Cross is the winner!")
      :tie -> IO.puts("It's a tie.")
      :none -> next_move(state)
    end
  end
  
  defp next_move(state) do
    player_move_function = state.player_move_functions[state.current_player]
    case player_move_function.(state) do
      :halt -> :halt
      move -> move |> apply_move(state) |> play()
    end
  end
  
  defp apply_move({row, column}, state) do
    %GameState{state | 
      board: Board.set_value(state.board, row, column, state.current_player), 
      current_player: (if state.current_player == :naught, do: :cross, else: :naught)
    }
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
  
  defp get_board_cell_character(%BoardCell{value: value}) do
    case value do
      :empty -> " "
      :naught -> "o"
      :cross -> "x"
    end
  end
end
