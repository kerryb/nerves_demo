defmodule DemoUiWeb.PageController do
  use DemoUiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
