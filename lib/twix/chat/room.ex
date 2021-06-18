defmodule Twix.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Auth.User

  schema "rooms" do
    field :description, :string
    field :name, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :description])
    |> validate_length(:name, min: 5, max: 30)
    |> validate_length(:description, min: 10, max: 300)
    |> unique_constraint(:name)
  end
end
