defmodule Tutorial.Repo.Migrations.CreateShopProducts do
  use Ecto.Migration

  def change do
    create table(:shop_products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :archived_at, :naive_datetime

      timestamps()
    end

  end
end
