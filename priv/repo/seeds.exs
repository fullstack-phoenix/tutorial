# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tutorial.Repo.insert!(%Tutorial.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Tutorial.Cities
alias Tutorial.Customers


cities = Cities.list_cities()

# SEED CUSTOMERS
max_customers = 100
customers_count = Enum.count(Customers.list_customers())
max_customers = Enum.max([max_customers - customers_count, 0])

Enum.each(0..max_customers, fn _ ->
  city = Enum.random(cities)

  %{
    name: Faker.Company.En.name(),
    address: Faker.Address.En.street_address(),
    city: city.city,
    latitude: city.latitude,
    longitude: city.longitude,
    phone: Faker.Phone.EnUs.phone(),
    zip: Faker.Address.En.zip_code()
  }
  |> Tutorial.Customers.create_customer()
end)
