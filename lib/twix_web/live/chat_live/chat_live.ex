defmodule TwixWeb.ChatLive do
  use TwixWeb, :live_view

  alias Twix.Repo.RoomRepo

  @chat_topic "chat_topic"
  @new_room "new_room"

  @impl true
  def mount(_params, %{"current_user_id" => _current_user_id}, socket) do
    if connected?(socket), do: TwixWeb.Endpoint.subscribe(@chat_topic)
    rooms = RoomRepo.get_rooms()
    {:ok, assign(socket, rooms: rooms), temporary_assigns: [rooms: []]}
  end

  @impl true
  def handle_info(%{event: @new_room, payload: new_room}, socket) do
    {:noreply, assign(socket, rooms: [new_room])}
  end
end
