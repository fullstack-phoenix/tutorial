defmodule TutorialWeb.CustomerLive.Index do
  use TutorialWeb, :live_view

  alias Tutorial.Customers
  alias Tutorial.Customers.Customer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :customers, list_customers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
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

    {:noreply, assign(socket, :customers, list_customers())}
  end

  defp list_customers do
    Customers.list_customers()
  end
end
