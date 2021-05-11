defmodule Tutorial.Todo do
  @moduledoc """
  The Todo context.
  """

  alias Tutorial.Todo.Task

  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  # THIS IS JUST HARDECODED DATA FOR DEMO PURPOSE
  defmodule User do
    defstruct name: nil, image: nil
  end

  def list_users() do
    [
      %User{
        name: "Tom Cook",
        image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
      },
      %User{
        name: "Hellen Schmidt",
        image: "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
      },
      %User{
        name: "Emil Schaefer",
        image: "https://images.unsplash.com/photo-1561505457-3bcad021f8ee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
      }
    ]
  end
end
