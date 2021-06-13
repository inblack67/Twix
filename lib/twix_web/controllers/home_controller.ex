defmodule TwixWeb.HomeController do
  use TwixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
