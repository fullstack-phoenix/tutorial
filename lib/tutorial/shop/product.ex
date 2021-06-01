defmodule Tutorial.Shop.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shop_products" do
    field :archived_at, :naive_datetime
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :archived_at])
    |> validate_required([:name])
  end
end
