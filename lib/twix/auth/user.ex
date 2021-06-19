defmodule Twix.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Auth.User
  alias Twix.Feed.Post
  alias Twix.Chat.Room
  alias Twix.Chat.Message

  schema "users" do
    field(:_id, :string)
    field(:email, :string)
    field(:password_hash, :string)
    field(:username, :string)

    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    has_many(:posts, Post)
    has_many(:rooms, Room)
    has_many(:messages, Message)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :_id])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:username, min: 2, max: 30)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password], [])
    |> validate_confirmation(:password)
    |> validate_length(:password, min: 8, max: 100)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
