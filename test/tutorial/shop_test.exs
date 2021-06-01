defmodule Tutorial.ShopTest do
  use Tutorial.DataCase

  alias Tutorial.Shop

  describe "shop_products" do
    alias Tutorial.Shop.Product

    @valid_attrs %{archived_at: ~N[2010-04-17 14:00:00], name: "some name"}
    @update_attrs %{archived_at: ~N[2011-05-18 15:01:01], name: "some updated name"}
    @invalid_attrs %{archived_at: nil, name: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shop.create_product()

      product
    end

    test "list_shop_products/0 returns all shop_products" do
      product = product_fixture()
      assert Shop.list_shop_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Shop.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Shop.create_product(@valid_attrs)
      assert product.archived_at == ~N[2010-04-17 14:00:00]
      assert product.name == "some name"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Shop.update_product(product, @update_attrs)
      assert product.archived_at == ~N[2011-05-18 15:01:01]
      assert product.name == "some updated name"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_product(product, @invalid_attrs)
      assert product == Shop.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Shop.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Shop.change_product(product)
    end
  end
end
