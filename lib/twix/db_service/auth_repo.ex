defmodule Twix.Repo.AuthRepo do
  alias Twix.Repo.UserRepo

  def sign_in(username, password) do
    user = UserRepo.get_user_by_username(username)
    is_valid_password = Argon2.verify_pass(password, user.password_hash)

    cond do
      user && is_valid_password -> {:ok, user}
      true -> {:error, :unauthorized}
    end
  end
end
