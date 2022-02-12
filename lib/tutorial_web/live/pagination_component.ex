defmodule TutorialWeb.Live.PaginationComponent do
  use TutorialWeb, :live_component
  import TutorialWeb.Live.DataTable

  @distance 4

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(pagination_assigns(assigns[:pagination_data]))
    }
  end

  def render(assigns) do
    ~H"""
    <div id={assigns[:id] || "pagination"} class="flex justify-center my-2">
      <%= if @total_pages > 1 do %>
        <div class="btn-group">
          <%= prev_link(@params, @page_number) %>
          <%= for num <- start_page(@page_number)..end_page(@page_number, @total_pages) do %>
            <%= live_patch num, to: "?#{querystring(@params, page: num)}", class: "btn btn-link #{if @page_number == num, do: "btn-active", else: ""}" %>
          <% end %>
          <%= next_link(@params, @page_number, @total_pages) %>
        </div>
      <% end %>
    </div>
    """
  end

  defp pagination_assigns(%Scrivener.Page{} = pagination) do
    [
      page_number: pagination.page_number,
      page_size: pagination.page_size,
      total_entries: pagination.total_entries,
      total_pages: pagination.total_pages,
    ]
  end

  def prev_link(conn, current_page) do
    if current_page != 1 do
      live_patch "Prev", to: "?" <> querystring(conn, page: current_page - 1), class: "btn btn-link"
    else
      live_patch "Prev", to: "#", class: "btn btn-link btn-disabled"
    end
  end

  def next_link(conn, current_page, num_pages) do
    if current_page != num_pages do
      live_patch "Next", to: "?" <> querystring(conn, page: current_page + 1), class: "btn btn-link"
    else
      live_patch "Next", to: "#", class: "btn btn-link btn-disabled"
    end
  end

  def start_page(current_page) when current_page - @distance <= 0, do: 1

  def start_page(current_page), do: current_page - @distance

  def end_page(current_page, 0), do: current_page

  def end_page(current_page, total)
       when current_page <= @distance and @distance * 2 <= total do
    @distance * 2
  end

  def end_page(current_page, total) when current_page + @distance >= total do
    total
  end

  def end_page(current_page, _total), do: current_page + @distance - 1
end
