defmodule TwixWeb.RoomController do
  use TwixWeb, :controller

  alias Twix.Repo.RoomRepo

  plug :protect_me

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    render(conn, "new.html", changeset: conn)
  end

  def create(conn, %{"room" => room_input}) do
    room_with_user_id = Map.put(room_input, "user_id", conn.assigns.current_user.id)

    case RoomRepo.create_room(room_with_user_id) do
      {:ok, _room} ->
        conn
        |> put_flash(:info, "Room created")
        |> redirect(to: Routes.chat_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp protect_me(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to Sign In")
      |> redirect(to: Routes.auth_path(conn, :new))
      |> halt()
    end
  end
end
