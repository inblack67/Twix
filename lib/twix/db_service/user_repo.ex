defmodule Twix.Repo.UserRepo do
  alias Twix.Repo
  alias Twix.Auth.User

  def register_user(user) do
    user_with_id =
      Map.put(
        user,
        "_id",
        UUID.uuid4()
      )

    IO.inspect(user_with_id)

    User.registration_changeset(%User{}, user_with_id)
    |> Repo.insert()
  end
end
