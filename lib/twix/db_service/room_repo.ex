defmodule Twix.Repo.RoomRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Chat.Room

  def create_room(user, %{"name" => name, "description" => description}) do
    room =
      user
      |> Ecto.build_assoc(:rooms, name: name, description: description, _id: UUID.uuid4())

    Room.changeset(room, %{})
    |> Repo.insert()
  end

  def get_rooms() do
    Repo.all(from(r in Room, order_by: [desc: r.inserted_at]))
    |> Repo.preload(:user)
  end

  def get_room_by_name(name) do
    Repo.get_by!(Room, name: name)
  end

  def room_changeset() do
    Room.changeset(%Room{}, %{})
  end
end
