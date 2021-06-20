defmodule TwixWeb.ChatLive.Messages do
  use TwixWeb, :live_component

  alias Twix.Repo.MessageRepo
  alias Twix.Chat.Message

  @room_topic "room_topic"
  @new_message "new_message"

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    if connected?(socket), do: TwixWeb.Endpoint.subscribe(@room_topic)

    changeset = Message.changeset(%Message{}, %{})
    # messages = MessageRepo.get_messages(assigns.room)

    {:ok,
     assign(socket,
       current_user_id: assigns.current_user_id,
       room: assigns.room,
       changeset: changeset,
       messages: assigns.messages,
       temporary_assigns: [assigns.messages]
     )}
  end

  @impl true
  def handle_event("validate", %{"message" => message}, socket) do
    changeset =
      Message.changeset(%Message{}, message)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"message" => message_input}, socket) do
    case MessageRepo.create_message(
           message_input,
           socket.assigns.room,
           socket.assigns.current_user_id
         ) do
      {:ok, message} ->
        TwixWeb.Endpoint.broadcast(@room_topic, @new_message, message)
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => message_id}, socket) do
    case MessageRepo.delete_message(message_id, socket.assigns.current_user_id) do
      {1, nil} ->
        {:noreply,
         socket
         |> put_flash(:info, "Message deleted")
         |> push_redirect(to: Routes.chat_room_path(socket, :index, socket.assigns.room.name))}

      {0, nil} ->
        {:noreply, socket}
    end
  end
end
