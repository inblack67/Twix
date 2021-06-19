defmodule TwixWeb.ChatLive.Room do
  use TwixWeb, :live_view

  alias Twix.Repo.RoomRepo

  def mount(%{"name" => room_name}, %{"current_user_id" => _current_user_id}, socket) do
    room = RoomRepo.get_room_by_name(room_name)
    {:ok, assign(socket, current_room: room)}
  end
end
