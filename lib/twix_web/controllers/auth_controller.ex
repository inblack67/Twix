defmodule TwixWeb.AuthController do
  use TwixWeb, :controller

  # login => new session
  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, _params) do
    conn
  end
end
