defmodule TwixWeb.RegistrationController do
  use TwixWeb, :controller

  alias Twix.Repo.UserRepo

  def new(conn, _params) do
    render(conn, "new.html", changeset: conn)
  end

  def create(conn, %{"registration" => registration_input}) do
    case UserRepo.register_user(registration_input) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "You have Signed Up")
        |> redirect(to: Routes.auth_path(conn, :new))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
