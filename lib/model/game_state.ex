defmodule GameState do
  @enforce_keys [:board]
  defstruct board: nil, current_player: :naught, player_move_functions: nil, key_position_lookup: nil
end
