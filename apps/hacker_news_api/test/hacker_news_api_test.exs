defmodule HackerNewsApiTest do
  use ExUnit.Case
  doctest HackerNewsApi

  test "greets the world" do
    assert HackerNewsApi.hello() == :world
  end
end
