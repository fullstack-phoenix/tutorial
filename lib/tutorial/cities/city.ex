defmodule Tutorial.Cities.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :city, :string
    field :latitude, :float
    field :longitude, :float
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:city, :state, :latitude, :longitude])
    |> validate_required([:city, :state, :latitude, :longitude])
  end
end
