defmodule Twix.Chat.Messages do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Auth.User
  alias Twix.Chat.Room

  schema "messages" do
    field :content, :string
    field :type, :string, default: "text"

    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(messages, attrs) do
    messages
    |> cast(attrs, [:content, :type])
    |> validate_required([:content])
  end
end
