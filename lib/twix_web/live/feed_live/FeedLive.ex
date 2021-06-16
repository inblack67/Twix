defmodule TwixWeb.FeedLive do
  use TwixWeb, :live_view

  alias Twix.Repo.PostRepo

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: TwixWeb.Endpoint.subscribe("ptopic")

    posts = PostRepo.get_posts()
    {:ok, assign(socket, posts: posts), temporary_assigns: [posts: []]}
  end

  @impl true
  def handle_info(%{event: "new_post", payload: new_post}, socket) do
    {:noreply, assign(socket, posts: [new_post])}
  end
end
