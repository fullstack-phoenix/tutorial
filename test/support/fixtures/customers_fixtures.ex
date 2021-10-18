defmodule Tutorial.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tutorial.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        address: "some address",
        city: "some city",
        latitude: 120.5,
        longitude: 120.5,
        name: "some name",
        phone: "some phone",
        zip: "some zip"
      })
      |> Tutorial.Customers.create_customer()

    customer
  end
end
