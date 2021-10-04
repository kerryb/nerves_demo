defmodule DemoFw do
  use GenServer

  alias Circuits.GPIO

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_) do
    :ok = Phoenix.PubSub.subscribe(DemoUi.PubSub, "commands")
    {:ok, led} = GPIO.open(4, :output)
    {:ok, %{led: led, led_on?: false}}
  end

  def handle_info(:toggle_led, state) do
    led_on? = not state.led_on?
    GPIO.write(state.led, if(led_on?, do: 1, else: 0))
    {:noreply, %{state | led_on?: led_on?}}
  end
end
