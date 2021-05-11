defmodule TutorialWeb.PageLive do
  use TutorialWeb, :live_view

  alias Tutorial.Todo
  alias Tutorial.Todo.Task

  alias TutorialWeb.Live.CustomSelectComponent

  @impl true
  def mount(_params, _session, socket) do
    changeset = Todo.change_task(%Task{})
    users = Todo.list_users()

    {
      :ok,
      socket
      |> assign(:changeset, changeset)
      |> assign(:users, users)
    }
  end

  @impl true
  def handle_event("update", %{"task" => task_params}, socket) do
    changeset =
      %Task{}
      |> Todo.change_task(task_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
