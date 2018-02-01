defmodule BackqikTest do
  use ExUnit.Case
  doctest Backqik

  test "greets the world" do
    assert Backqik.hello() == :world
  end
end
