defmodule Tutorial.Repo.Migrations.AddDataColumnToProducts do
  use Ecto.Migration

  def change do
    alter table(:shop_products) do
      add :data, :map, default: %{}, null: false
    end
  end
end
