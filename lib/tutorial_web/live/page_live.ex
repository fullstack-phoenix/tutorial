defmodule TutorialWeb.PageLive do
  use TutorialWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    assigns = [
      toggle: "off"
    ]
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def handle_event("toggle-change", %{"toggle" => toggle}, socket) do
    toggle = if toggle == "1", do: "on", else: "off"

    {:noreply, assign(socket, :toggle, toggle)}
  end
end
