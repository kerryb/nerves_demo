defmodule DemoFw do
  use GenServer

  alias Circuits.GPIO

  @led_pin 4
  @switch_pin 5

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_) do
    :ok = Phoenix.PubSub.subscribe(DemoUi.PubSub, "commands")
    {:ok, led} = GPIO.open(@led_pin, :output)
    {:ok, switch} = GPIO.open(@switch_pin, :input)
    :ok = GPIO.set_interrupts(switch, :both)
    # Note: we need to store switch gpio ref in state to stop it being
    # garbage-collected, which would mean we only received the first message
    {:ok, %{led: led, switch: switch, led_on?: false}}
  end

  def handle_info(:toggle_led, state) do
    led_on? = not state.led_on?
    GPIO.write(state.led, if(led_on?, do: 1, else: 0))
    Phoenix.PubSub.broadcast!(DemoUi.PubSub, "updates", {:led, led_on?})
    {:noreply, %{state | led_on?: led_on?}}
  end

  def handle_info({:circuits_gpio, @switch_pin, _timestamp, switch_position}, state) do
    Phoenix.PubSub.broadcast!(DemoUi.PubSub, "updates", {:switch, switch_position == 1})
    {:noreply, state}
  end
end
