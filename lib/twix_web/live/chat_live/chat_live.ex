defmodule TwixWeb.ChatLive do
  use TwixWeb, :live_view

  alias Twix.Repo.RoomRepo

  @chat_topic "chat_topic"
  @new_room "new_room"

  def mount(_params, %{"current_user_id" => _current_user_id}, socket) do
    rooms = RoomRepo.get_rooms()
    {:ok, assign(socket, rooms: rooms), temporary_assigns: [rooms: []]}
  end

  

end
