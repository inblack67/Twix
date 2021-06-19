defmodule TwixWeb.ChatLive.Room do
  use TwixWeb, :live_view

  def mount(%{"name" => room_name}, %{"current_user_id" => current_user_id}, socket) do
    {:ok, socket}
  end
end
