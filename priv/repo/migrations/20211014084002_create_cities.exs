defmodule Tutorial.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :city, :string, null: false
      add :state, :string, null: false
      add :latitude, :float, null: false
      add :longitude, :float, null: false

      timestamps()
    end

    unique_index(:cities, [:city, :state])
  end
end
