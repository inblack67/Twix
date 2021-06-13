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

  def get_current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)

    if user_id do
      UserRepo.get_user_by_id!(user_id)
    end
  end

  def is_user_signed_in?(conn), do: !!get_current_user(conn)

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end
end
