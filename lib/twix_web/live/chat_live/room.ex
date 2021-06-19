defmodule TwixWeb.ChatLive.Room do
  use TwixWeb, :live_view

  alias Twix.Repo.RoomRepo
  alias Twix.Repo.MessageRepo
  alias Twix.Chat.Message

  @room_topic "room_topic"
  @new_message "new_message"

  @impl true
  def mount(%{"name" => room_name}, %{"current_user_id" => current_user_id}, socket) do
    room = RoomRepo.get_room_by_name(room_name)

    {:ok,
     assign(socket, current_room: room, message: %Message{}, current_user_id: current_user_id)}
  end

  @impl true
  def handle_event("validate", %{"message" => message}, socket) do
    changeset =
      Message.changeset(socket.assigns.message, message)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"message" => message_input}, socket) do
    case MessageRepo.create_message(
           message_input,
           socket.assigns.current_room.id,
           socket.assigns.current_user_id
         ) do
      {:ok, message} ->
        TwixWeb.Endpoint.broadcast(@room_topic, @new_message, message)

      {:error, %Ecto.Changeset{} = changeset} ->
        socket
        |> assign(changeset: changeset)
    end

    {:noreply, socket}
  end
end
