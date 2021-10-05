# Nerves demo

Comprises a UI app (Phoenix LiveView) with a button and a status indicator, and
a firmware app that talks to the UI over PubSub and interfaces with an LED and
a switch on a Raspberry Pi.

The Pi should have an LED and resistor from GPIO4 to ground, and a switch from
GPIO5 to ground, with a pull-up resistor (similar to the
[hello_gpio](https://github.com/nerves-project/nerves_examples/tree/main/hello_gpio)
example.

## Building

```
cd demo_ui
mix phx.digest
cd ../demo_fw
MIX_TARGET=rpi0 MIX_ENV=prod mix firmware.burn
```
