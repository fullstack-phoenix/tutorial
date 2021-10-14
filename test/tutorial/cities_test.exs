defmodule Tutorial.CitiesTest do
  use Tutorial.DataCase

  alias Tutorial.Cities

  describe "cities" do
    alias Tutorial.Cities.City

    import Tutorial.CitiesFixtures

    @invalid_attrs %{city: nil, latitude: nil, longitude: nil, state: nil}

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Cities.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Cities.get_city!(city.id) == city
    end

    test "create_city/1 with valid data creates a city" do
      valid_attrs = %{city: "some city", latitude: 120.5, longitude: 120.5, state: "some state"}

      assert {:ok, %City{} = city} = Cities.create_city(valid_attrs)
      assert city.city == "some city"
      assert city.latitude == 120.5
      assert city.longitude == 120.5
      assert city.state == "some state"
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cities.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      update_attrs = %{city: "some updated city", latitude: 456.7, longitude: 456.7, state: "some updated state"}

      assert {:ok, %City{} = city} = Cities.update_city(city, update_attrs)
      assert city.city == "some updated city"
      assert city.latitude == 456.7
      assert city.longitude == 456.7
      assert city.state == "some updated state"
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Cities.update_city(city, @invalid_attrs)
      assert city == Cities.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Cities.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Cities.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Cities.change_city(city)
    end
  end
end
