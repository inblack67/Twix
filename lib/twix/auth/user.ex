defmodule Twix.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Auth.User

  schema "users" do
    field(:_id, :string, default: UUID.uuid4())
    field(:email, :string)
    field(:password_hash, :string)
    field(:username, :string)

    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_confirmation(:password)
    |> validate_length(:username, min: 2, max: 30)
    |> validate_length(:password, min: 8, max: 100)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Argon2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
