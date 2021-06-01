defmodule Tutorial.Shop.Data do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :size, :string
    field :color, :string
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:size, :color])
    |> validate_required([])
  end
end
