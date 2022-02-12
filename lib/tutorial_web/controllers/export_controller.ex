defmodule TutorialWeb.ExportController do
  use TutorialWeb, :controller

  alias Tutorial.Customers

  def create(conn, %{"export_field" => export_fields} = _params) do
    fields =
      Enum.reduce(export_fields, [], fn {field, active}, acc ->
        field = String.to_existing_atom(field)
        if active == "true", do: [field|acc], else: acc
      end)

    csv_data = csv_content(Customers.list_customers(), fields)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"export.csv\"")
    |> put_root_layout(false)
    |> send_resp(200, csv_data)
  end

  defp csv_content(records, fields) do
    records
    |> Enum.map(fn record ->
      record
      |> Map.from_struct()
      |> Map.take([]) # gives an empty map
      |> Map.merge( Map.take(record, fields) )
      |> Map.values()
    end)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
