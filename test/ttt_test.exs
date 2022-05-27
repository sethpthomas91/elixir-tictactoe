defmodule TttTest do
  use ExUnit.Case
  doctest Ttt

  test "greets the world" do
    assert Ttt.hello() == :world
  end
end
