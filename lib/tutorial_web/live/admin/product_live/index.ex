defmodule TutorialWeb.Admin.ProductLive.Index do
  use TutorialWeb, :live_view

  alias Tutorial.Shop
  alias Tutorial.Shop.Product

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :shop_products, list_shop_products())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Shop.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Shop products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Shop.get_product!(id)
    {:ok, _} = Shop.delete_product(product)

    {:noreply, assign(socket, :shop_products, list_shop_products())}
  end

  defp list_shop_products do
    Shop.list_shop_products()
  end
end
