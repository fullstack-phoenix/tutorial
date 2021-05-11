defmodule TutorialWeb.PageLive do
  use TutorialWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, [])}
  end
end
