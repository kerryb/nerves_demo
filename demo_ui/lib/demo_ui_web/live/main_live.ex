defmodule DemoUiWeb.MainLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <h1>Nerves demo</h1>
    <form action="#">
      <button class="button" name="toggle-led" phx-click="toggle-led">Toggle LED</button>
      <p>
        Switch is
        <%= if @switch_on? do %>
          <span class="on">ON</span>
        <% else %>
          <span class="off">OFF</span>
        <% end %>
      </p>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(DemoUi.PubSub, "updates")
    end

    {:ok, assign(socket, led_on?: false, switch_on?: false)}
  end

  def handle_event("toggle-led", _params, socket) do
    Phoenix.PubSub.broadcast!(DemoUi.PubSub, "commands", :toggle_led)
    {:noreply, socket}
  end

  def handle_info({:switch, on?}, socket) do
    {:noreply, assign(socket, switch_on?: on?)}
  end
end
