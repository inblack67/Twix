defmodule TwixWeb.FeedLive do
  use TwixWeb, :live_view

  alias Twix.Repo.PostRepo

  @feed_topic "feed_topic"
  @new_post "new_post"

  @impl true
  def mount(_params, %{"current_user_id" => current_user_id}, socket) do
    if connected?(socket), do: TwixWeb.Endpoint.subscribe(@feed_topic)

    posts = PostRepo.get_posts()

    {:ok, assign(socket, posts: posts, current_user_id: current_user_id),
     temporary_assigns: [posts: []]}
  end

  @impl true
  def handle_info(%{event: @new_post, payload: new_post}, socket) do
    {:noreply, assign(socket, posts: [new_post])}
  end

  @impl true
  def handle_event("delete", %{"id" => post_id}, socket) do
    case PostRepo.delete_post(post_id, socket.assigns.current_user_id) do
      {1, nil} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post deleted")
         |> push_redirect(to: Routes.feed_path(socket, :index))}

      {0, nil} ->
        {:noreply, socket}
    end
  end
end
