defmodule NaughtsAndCrossesWeb.PageController do
  use NaughtsAndCrossesWeb, :controller
  alias NaughtsAndCrosses.GameState
  alias NaughtsAndCrosses.Board
  alias NaughtsAndCrosses.AiPlayer

  def index(conn, params) do
    options = add_defaults(params, %{ "player" => "naughts", "board-size" => "3" })
    
    board_size = String.to_integer(options["board-size"]);
    state = %GameState{ board: Board.create(board_size) }
    next_state = (if options["player"] == "naughts", do: state, else: GameState.apply_move(state, AiPlayer.get_move(state)))
    
    conn = conn
      |> put_session(:state, next_state)
      |> put_session(:options, options)
    render conn, "index.html", board: next_state.board, options: options
  end
  
  def place(conn, %{ "row" => row, "column" => column }) do
    state = get_session(conn, :state)
    status_message = get_status_message(state)
    if status_message != "" do
      json conn, %{ placements: [], message: status_message }
    else
      row_number = String.to_integer(row)
      column_number = String.to_integer(column)
    
      {placements, next_state, message} = cond do
        Board.get_value(state.board, row_number, column_number) == :empty ->
          {placements, new_state} = move(state, row_number, column_number)
          {placements, new_state, get_status_message(new_state)}
        true -> 
          {[], state, "Invalid move"}
      end
    
      conn = put_session(conn, :state, next_state)
      json conn, %{ placements: placements, message: message }
    end
  end
  
  defp move(state, row, column) do
    next_state = state |> GameState.apply_move({row, column})
    if Board.get_winner(next_state.board) == :none do
      {ai_move_row, ai_move_column} = AiPlayer.get_move(next_state)
      {[%{row: row, column: column, symbol: state.current_player}, %{row: ai_move_row, column: ai_move_column, symbol: next_state.current_player}], 
        next_state |> GameState.apply_move({ai_move_row, ai_move_column})}
    else
      {[%{row: row, column: column, symbol: state.current_player}], next_state}
    end
  end
  
  defp get_status_message(state) do
    case Board.get_winner(state.board) do
      :naught -> "Naughts wins!"
      :cross -> "Crosses wins!"
      :tie -> "It's a tie."
      :none -> ""
    end
  end
  
  defp add_defaults(params, defaults) do
    Map.merge(params, defaults, fn _key, value1, _value2 -> value1 end)
  end
end
