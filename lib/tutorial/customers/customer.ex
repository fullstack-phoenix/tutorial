defmodule Tutorial.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :address, :string
    field :city, :string
    field :latitude, :float
    field :longitude, :float
    field :name, :string
    field :phone, :string
    field :zip, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :address, :zip, :city, :phone, :longitude, :latitude])
    |> validate_required([:name, :address, :zip, :city, :phone, :longitude, :latitude])
  end
end
