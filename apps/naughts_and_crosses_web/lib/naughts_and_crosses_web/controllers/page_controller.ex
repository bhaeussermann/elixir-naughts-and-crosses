defmodule NaughtsAndCrossesWeb.PageController do
  use NaughtsAndCrossesWeb, :controller
  alias NaughtsAndCrosses.GameState
  alias NaughtsAndCrosses.Board
  alias NaughtsAndCrosses.AiPlayer

  def index(conn, _params) do
    state = %GameState{ board: Board.create(3) }
    conn = put_session(conn, :state, state)
    render conn, "index.html", board: state.board, message: ""
  end
  
  def place(conn, %{ "row" => row, "column" => column }) do
    state = get_session(conn, :state)
    status_message = get_status_message(state)
    if status_message != "" do
      render conn, "index.html", board: state.board, message: status_message
    else
      row_number = String.to_integer(row)
      column_number = String.to_integer(column)
    
      {next_state, message} = cond do
        Board.get_value(state.board, row_number, column_number) == :empty ->
          new_state = move(state, row_number, column_number)
          { new_state, get_status_message(new_state) }
        true -> 
          { state, "Invalid move" }
      end
    
      conn = put_session(conn, :state, next_state)
      render conn, "index.html", board: next_state.board, message: message
    end
  end
  
  defp move(state, row, column) do
    next_state = state |> GameState.apply_move({row, column})
    if Board.get_winner(next_state.board) == :none do
      next_state |> GameState.apply_move(AiPlayer.get_move(next_state))
    else
      next_state
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
end
