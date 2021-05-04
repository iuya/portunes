defmodule PortunesCoreTest do
  use ExUnit.Case
  doctest PortunesCore

  test "greets the world" do
    assert PortunesCore.hello() == :world
  end
end
