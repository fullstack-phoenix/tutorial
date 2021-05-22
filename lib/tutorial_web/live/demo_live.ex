defmodule TutorialWeb.DemoLive do
  use TutorialWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
    }
  end

  @impl true
  def handle_event("close-modal", %{"modal-id" => id}, socket) do
    # send_update TutorialWeb.Components.Modal, id: id, state: "CLOSED"
    {
      :noreply,
      socket
      |> push_event("close", %{id: id})
    }
  end
end
