defmodule TwixWeb.ChatLive.Messages do
  use TwixWeb, :live_component

  def update(assigns, socket) do
    {:ok, assign(socket, room: assigns.room)}
  end
end
