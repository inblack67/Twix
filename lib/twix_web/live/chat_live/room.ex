defmodule TwixWeb.ChatLive.Room do
  use TwixWeb, :live_view

  alias Twix.Repo.RoomRepo
  alias Twix.Chat.Message
  alias Twix.Repo.MessageRepo

  @new_message "new_message"

  @impl true
  def mount(%{"name" => room_name}, %{"current_user_id" => current_user_id}, socket) do
    room = RoomRepo.get_room_by_name(room_name)

    messages = MessageRepo.get_messages(room)

    {:ok,
     assign(socket,
       current_room: room,
       message: %Message{},
       current_user_id: current_user_id,
       messages: messages
     )}
  end

  @impl true
  def handle_info(%{event: @new_message, payload: new_message}, socket) do
    {:noreply, assign(socket, messages: [new_message])}
  end
end
