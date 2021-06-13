defmodule TwixWeb.AuthController do
  use TwixWeb, :controller

  alias Twix.Repo.AuthRepo

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
end
