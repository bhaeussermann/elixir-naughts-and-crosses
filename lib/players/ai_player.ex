defmodule AiPlayer do
  def get_move(state) do
    board = state[:board]
    if (Enum.count(board) == 3) and (board |> Board.get_value(1, 1) == :empty) do
      {1, 1}
    else
      target_line = get_target_line(state)
      [position: empty_position, value: _] = Enum.find(target_line, fn([position: _, value: value]) -> value == :empty end)
      empty_position
    end
  end
  
  def get_open_space_count([], _) do
    0
  end
  
  def get_open_space_count([[position: _, value: :empty] | tail], player) do
    tail_count = get_open_space_count(tail, player)
    if tail_count == :not_open, do: :not_open, else: tail_count + 1
  end
  
  def get_open_space_count([[position: _, value: player] | tail], player) do
    get_open_space_count(tail, player)
  end
  
  def get_open_space_count(_, _) do
    :not_open
  end
  
  defp get_target_line(state) do
    lines = state[:board] |> Board.get_lines
    current_player = state[:current_player]
    
    winning_line = Enum.find(lines, &(get_open_space_count(&1, current_player) == 1))
    if winning_line do
      winning_line
    else
      opponent_player = if current_player == :naught, do: :cross, else: :naught
      threatening_line = Enum.find(lines, &(get_open_space_count(&1, opponent_player) == 1))
      if threatening_line do
        threatening_line
      else
        open_lines = Enum.filter(lines, &(Enum.any?(&1, fn([position: _, value: value]) -> value == :empty end)))
        Enum.min_by(open_lines, &(get_open_space_count(&1, current_player)))
      end
    end
  end
end
