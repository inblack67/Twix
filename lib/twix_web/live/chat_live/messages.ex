defmodule TwixWeb.ChatLive.Messages do
  use TwixWeb, :live_component

  alias Twix.Repo.MessageRepo
  alias Twix.Chat.Message

  @impl true
  def update(assigns, socket) do
    changeset = Message.changeset(%Message{}, %{})
    messages = MessageRepo.get_messages()
    IO.inspect(messages)

    {:ok,
     assign(socket,
       room: assigns.room,
       changeset: changeset,
       messages: messages,
       temporary_assigns: [messages]
     )}
  end
end
