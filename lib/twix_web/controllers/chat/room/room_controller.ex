defmodule TwixWeb.RoomController do
  use TwixWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    IO.puts("room :create")
    IO.inspect(conn)
    IO.inspect(params)
    conn
  end
end
