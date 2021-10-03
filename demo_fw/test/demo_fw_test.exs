defmodule DemoFwTest do
  use ExUnit.Case
  doctest DemoFw

  test "greets the world" do
    assert DemoFw.hello() == :world
  end
end
