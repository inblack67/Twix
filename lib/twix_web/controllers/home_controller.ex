defmodule TwixWeb.HomeController do
  use TwixWeb, :controller
  plug :protect_me

  def index(conn, _params) do
    render(conn, "index.html")
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
