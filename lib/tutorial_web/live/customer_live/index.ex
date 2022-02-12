defmodule TutorialWeb.CustomerLive.Index do
  use TutorialWeb, :live_view

  import TutorialWeb.Live.DataTable

  alias TutorialWeb.Live.InitAssigns

  alias Tutorial.Customers
  alias Tutorial.Customers.Customer

  on_mount {InitAssigns, :load_customers}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {
      :noreply,
      socket
      |> assign(:params, params)
      |> assign(:customers, list_customers(params))
      |> apply_action(socket.assigns.live_action, params)
    }
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Customer")
    |> assign(:customer, Customers.get_customer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Customer")
    |> assign(:customer, %Customer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Customers")
    |> assign(:customer, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    customer = Customers.get_customer!(id)
    {:ok, _} = Customers.delete_customer(customer)
    InitAssigns.expire_cache()

    {:noreply, assign(socket, :customers, list_customers(socket.assigns.params))}
  end

  defp list_customers(params) do
    hash = :erlang.phash2(params)
    InitAssigns.with_cache("customers-cache-#{hash}", (fn ->
      Customers.list_customers(params)
    end))
  end
end
