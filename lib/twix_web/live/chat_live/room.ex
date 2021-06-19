defmodule TwixWeb.ChatLive.Room do
  use TwixWeb, :live_view

  alias Twix.Repo.RoomRepo
  alias Twix.Repo.MessageRepo
  alias Twix.Chat.Message

  @impl true
  def mount(%{"name" => room_name}, %{"current_user_id" => _current_user_id}, socket) do
    room = RoomRepo.get_room_by_name(room_name)
    {:ok, assign(socket, current_room: room, message: %Message{})}
  end

  @impl true
  def handle_event("validate", %{"message" => message}, socket) do
    changeset =
      Message.changeset(socket.assigns.message, message)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"message" => message}, socket) do
    changeset = Message.changeset(%Message{}, message)
    {:noreply, assign(socket, changeset: changeset)}
  end
end
