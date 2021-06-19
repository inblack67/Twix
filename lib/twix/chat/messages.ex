defmodule Twix.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Auth.User
  alias Twix.Chat.Room

  schema "messages" do
    field :content, :string
    field :type, :string, default: "text"
    field :_id, :string

    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :type, :_id])
    |> validate_required([:content])
    |> validate_length(:content, min: 1)
  end
end
