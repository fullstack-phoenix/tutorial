defmodule TutorialWeb.Live.SharedComponents do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  def dropdown(assigns) do
    assigns =
      assigns
      |> assign_new(:id, fn -> "dom#{System.unique_integer()}" end)

    ~H"""
    <div class="relative inline-block text-left">
      <button class="btn btn-secondary" phx-click={ JS.toggle(to: "##{@id}", in: {"duration-300", "opacity-0", "opacity-100"}, out: {"duration-75", "opacity-100", "opacity-0"})  } >
        <%= render_slot(@toggle) %>
      </button>
      <div id={@id} class="absolute right-0 z-20 hidden" phx-click-away={JS.hide(to: "##{@id}", transition: {"duration-75", "opacity-100", "opacity-0"})}>
        <%= render_slot(@inner_block, assigns) %>
      </div>
    </div>
    """
  end
end
