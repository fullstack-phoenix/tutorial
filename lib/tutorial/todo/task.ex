defmodule Tutorial.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tutorial.Todo.Task

  embedded_schema do
    field :assignee, :string
  end

  @doc false
  def changeset(%Task{} = task, attrs \\ %{}) do
    task
    |> cast(attrs, [:assignee])
    |> validate_required([:assignee])
  end
end
