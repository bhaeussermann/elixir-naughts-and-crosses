defmodule NaughtsAndCrosses.GameState do
  alias NaughtsAndCrosses.GameState
  alias NaughtsAndCrosses.Board
  
  @enforce_keys [:board]
  defstruct board: nil, current_player: :naught, player_move_functions: nil, key_position_lookup: nil
  
  def apply_move(state, {row, column}) do
    %GameState{state | 
      board: Board.set_value(state.board, row, column, state.current_player), 
      current_player: (if state.current_player == :naught, do: :cross, else: :naught)
    }
  end
end
