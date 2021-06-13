defmodule TwixWeb.Plugs.SetUser do
  import Plug.Conn

  alias Twix.Repo.UserRepo

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)

    cond do
      user = user_id && UserRepo.get_user_by_id!(user_id) ->
        token = Phoenix.Token.sign(conn, "user_token", user_id)

        conn
        |> assign(:current_user, user)
        |> assign(:user_signed_in?, true)
        |> assign(:user_token, token)

      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end
end
