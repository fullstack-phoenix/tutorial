defmodule Tutorial.Scraper do
  @base_url "https://www.latlong.net"
  @initial_path "/category/cities-236-15.html"

  def run(path \\ @initial_path) do
    document = perform_request_and_parse_result(path)

    find_and_parse_rows(document)
    |> save_rows()

    maybe_paginate(document)
  end

  defp perform_request_and_parse_result("" <> path) do
    {:ok, %Finch.Response{body: body}} =
      Finch.build(:get, "#{@base_url}/#{path}")
      |> Finch.request(MyFinch)

    {:ok, document} = Floki.parse_document(body)

    document
  end

  defp find_and_parse_rows(document) do
    document
    |> Floki.find("table tr")
    |> Enum.map(&parse_row/1)
  end

  defp parse_row(
         {"tr", _,
          [
            {"td", _, [{"a", _, [city_state_country]}]},
            {"td", _, [latitude]},
            {"td", _, [longitude]}
          ]}
       ) do

    [city, state | _] =
      city_state_country
      |> String.split(",")
      |> Enum.map(& String.trim(&1))

    %{city: city, state: state, latitude: latitude, longitude: longitude}
  end

  defp parse_row(_), do: %{}

  defp save_rows(rows) do
    rows
    |> Enum.each(&Tutorial.Cities.create_city/1)
  end

  defp maybe_paginate(document) do
    document
    |> Floki.find(".pagination li a")
    |> Enum.find(fn row ->
      case row do
        {"a", [{"href", "/" <> _path}], ["next" <> _]} -> true
        _ -> false
      end
    end)
    |> case do
      nil ->
        :ok
      {_, [{_, "" <> path}], _} ->
        run(path)
    end
  end
end
