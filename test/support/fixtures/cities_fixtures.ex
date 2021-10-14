defmodule Tutorial.CitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tutorial.Cities` context.
  """

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{
        city: "some city",
        latitude: 120.5,
        longitude: 120.5,
        state: "some state"
      })
      |> Tutorial.Cities.create_city()

    city
  end
end
