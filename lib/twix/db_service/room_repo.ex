defmodule Twix.Repo.RoomRepo do
  alias Twix.Repo
  alias Twix.Chat.Room

  def create_room(room) do
    Room.changeset(%Room{}, room)
    |> Repo.insert()
  end

  def get_rooms() do
    Repo.all(Room)
  end

  def room_changeset() do
    Room.changeset(%Room{}, %{})
  end
end
