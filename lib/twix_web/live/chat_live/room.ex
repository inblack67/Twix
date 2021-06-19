defmodule TwixWeb.ChatLive.Room do
  use TwixWeb, :live_view

  alias Twix.Repo.RoomRepo
  alias Twix.Chat.Message

  @impl true
  def mount(%{"name" => room_name}, %{"current_user_id" => current_user_id}, socket) do
    room = RoomRepo.get_room_by_name(room_name)

    {:ok,
     assign(socket, current_room: room, message: %Message{}, current_user_id: current_user_id)}
  end
end
