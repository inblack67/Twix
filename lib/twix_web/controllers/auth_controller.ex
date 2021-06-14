defmodule TwixWeb.AuthController do
  use TwixWeb, :controller

  alias Twix.Repo.AuthRepo
  plug :protect_me when action in [:new, :create]

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"credentials" => %{"username" => username, "password" => password}}) do
    case AuthRepo.sign_in(username, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "You have Signed In")
        |> redirect(to: Routes.home_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid Credentials")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> AuthRepo.sign_out()
    |> put_flash(:info, "You have Signed Out")
    |> redirect(to: Routes.auth_path(conn, :new))
  end

  defp protect_me(conn, _params) do
    if !conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You have already Signed In")
      |> redirect(to: Routes.home_path(conn, :index))
      |> halt()
    end
  end
end
