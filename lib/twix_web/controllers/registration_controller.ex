defmodule TwixWeb.RegistrationController do
  use TwixWeb, :controller

  alias Twix.Repo.UserRepo

  plug :protect_me

  def new(conn, _params) do
    render(conn, "new.html", changeset: conn)
  end

  def create(conn, %{"registration" => registration_input}) do
    case UserRepo.register_user(registration_input) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "You have Signed Up, time to Sign In")
        |> redirect(to: Routes.auth_path(conn, :new))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
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
