defmodule Tutorial.Shop.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Tutorial.Shop.Data # <-- ADD THIS LINE

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "shop_products" do
    field :archived_at, :naive_datetime
    field :name, :string

    embeds_one :data, Data, on_replace: :update # <-- ADD THIS LINE

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :archived_at])
    |> validate_required([:name])
    |> cast_embed(:data) # <-- ADD THIS LINE
  end
end
