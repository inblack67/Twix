defmodule Twix.Repo.RoomRepo do
  import Ecto.Query, only: [from: 2]

  alias Twix.Repo
  alias Twix.Chat.Room

  def create_room(room) do
    room_with_uuid = Map.put(room, "_id", UUID.uuid4())

    Room.changeset(%Room{}, room_with_uuid)
    |> Repo.insert()
  end

  def get_rooms() do
    Repo.all(from(p in Room, order_by: [desc: p.inserted_at]))
  end

  def room_changeset() do
    Room.changeset(%Room{}, %{})
  end
end
