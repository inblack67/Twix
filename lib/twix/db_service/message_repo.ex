defmodule Twix.Repo.MessageRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Repo.UserRepo
  alias Twix.Chat.Message

  def get_messages(room, limit \\ 20) do
    Repo.all(
      from(m in Message,
        # join: user in assoc(m, :user),
        where: m.room_id == ^room.id,
        order_by: [desc: m.inserted_at],
        limit: ^limit
      )
    )
    |> Repo.preload(:user)
  end

  def create_message(%{"content" => content}, room, user_id) do
    user = UserRepo.get_user_by_id!(user_id)

    message_with_room =
      room
      |> Ecto.build_assoc(:messages, content: content)

    message_with_room_and_user =
      user
      |> Ecto.build_assoc(:messages, message_with_room)

    final_message_input = Map.put(message_with_room_and_user, :_id, UUID.uuid4())

    {:ok, message} =
      Message.changeset(final_message_input, %{})
      |> Repo.insert()

    loaded_message =
      message
      |> Repo.preload(:user)
      |> Repo.preload(:room)

    {:ok, loaded_message}
  end
end
