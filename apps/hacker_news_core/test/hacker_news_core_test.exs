defmodule HackerNewsCoreTest do
  use ExUnit.Case
  doctest HackerNewsCore

  test "greets the world" do
    assert HackerNewsCore.hello() == :world
  end
end
