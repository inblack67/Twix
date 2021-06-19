defmodule Twix.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Auth.User
  alias Twix.Chat.Messages

  schema "rooms" do
    field :description, :string
    field :name, :string
    field :_id, :string

    belongs_to :user, User
    has_many :messages, Messages

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description, :user_id, :_id])
    |> validate_required([:name, :description])
    |> validate_length(:name, min: 5, max: 30)
    |> validate_length(:description, min: 10, max: 300)
    |> unique_constraint(:name)
    |> update_change(:name, &String.trim(&1))
    |> update_change(:description, &String.trim(&1))
  end
end
