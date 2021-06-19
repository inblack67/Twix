defmodule Twix.Repo.MessageRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Repo.UserRepo
  alias Twix.Chat.Message

  def get_messages(limit \\ 20) do
    Repo.all(from(m in Message, limit: ^limit))
  end

  def create_message(%{"content" => content}, room, user_id) do
    user = UserRepo.get_user_by_id!(user_id)

    message_with_room =
      room
      |> Ecto.build_assoc(:messages, content: content)

    message_with_room_and_user =
      user
      |> Ecto.build_assoc(:messages, message_with_room)

    Message.changeset(message_with_room_and_user, %{})
    |> Repo.insert()
  end
end
