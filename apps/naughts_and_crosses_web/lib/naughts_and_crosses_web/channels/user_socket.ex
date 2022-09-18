defmodule NaughtsAndCrossesWeb.UserSocket do
  use Phoenix.Socket

  def connect(_params, socket) do
    {:ok, socket}
  end

  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
