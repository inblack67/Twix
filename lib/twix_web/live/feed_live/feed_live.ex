defmodule TwixWeb.FeedLive do
  use TwixWeb, :live_view

  @impl true
  def mount(_params, %{"current_user_id" => _current_user_id}, socket) do
    {:ok, socket}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:error, socket}
  end
end
