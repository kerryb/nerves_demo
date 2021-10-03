defmodule DemoUiWeb.MainLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <h1>Nerves demo</h1>
    <form>
      <button class="button" name="toggle-led">Turn LED on</button>
      <p>Switch is <span class="off">OFF</span></p>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
