defmodule TwixWeb.Router do
  use TwixWeb, :router

  alias TwixWeb.Plugs.SetUser

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TwixWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(SetUser)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TwixWeb do
    pipe_through :browser

    get("/", HomeController, :index)
    resources("/auth", AuthController, only: [:new, :create])
    delete("/sign_out", AuthController, :delete)
    resources("/registration", RegistrationController, only: [:new, :create])

    # live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TwixWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TwixWeb.Telemetry
    end
  end
end
