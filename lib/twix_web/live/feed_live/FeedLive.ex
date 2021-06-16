defmodule TwixWeb.FeedLive do
  use TwixWeb, :live_view

  alias Twix.Feed.Post

  @impl true
  def mount(_params, %{"current_user_id" => current_user_id}, socket) do
    changeset = Post.changeset(%Post{}, %{})

    {:ok,
     socket
     |> assign(:post, %Post{})
     |> assign(:changeset, changeset)
     |> assign(:current_user_id, current_user_id)}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("validate", %{"post" => post_input}, socket) do
    changeset =
      socket.assigns.post
      |> Post.changeset(post_input)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"post" => post_input}, socket) do
    IO.inspect(socket)

    Post.changeset(socket.assigns.post, post_input)
    |> IO.inspect()

    {:noreply, socket}
  end
end

# @impl true
# def handle_event("validate", %{"post" => post_params}, socket) do
#   changeset =
#     socket.assigns.post
#     |> PostRepo.post_changeset(post_params)
#     |> Map.put(:action, :validate)

#   {:noreply, assign(socket, :changeset, changeset)}
# end

# @impl true
# def handle_event("save", %{"post" => post_params}, socket) do
#   ready_post =
#     post_params
#     |> Map.put("user_id", socket.assigns.current_user_id)

#   case PostRepo.create_post(ready_post) do
#     {:ok, _post} ->
#       {:noreply,
#        socket
#        |> put_flash(:info, "Post created successfully")
#        |> push_redirect(to: socket.assigns.return_to)}

#     {:error, %Ecto.Changeset{} = changeset} ->
#       {:noreply, assign(socket, changeset: changeset)}
#   end
# end
