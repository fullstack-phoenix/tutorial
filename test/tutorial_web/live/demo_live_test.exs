defmodule TutorialWeb.DemoLiveTest do
  use TutorialWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/demo")
    assert disconnected_html =~ "Demo"
    assert render(page_live) =~ "Demo"
  end
end
