defmodule TwixWeb.ChatLive.Room do
  use TwixWeb, :live_view

  def mount(%{"name" => room_name}, %{"current_user_id" => _current_user_id}, socket) do
    {:ok, assign(socket, current_room: room_name)}
  end

end
