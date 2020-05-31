defmodule BrickTest do
  use ExUnit.Case

  import Tetris.Brick

  test "creates a new brick" do
    assert new_brick().name == :i
  end

  test "creates a new random brick" do
    actual = new_random()

    assert actual.name in [:i, :l, :z, :o, :t]
    assert actual.rotation in [0, 90, 180, 270]
    assert actual.reflection in [true, false]
  end

  test "should manipulate brick" do
    actual =
      new_brick()
      |> left
      |> right
      |> down
      |> spin_90
      |> spin_90

    assert actual.location == {40, 1}
    assert actual.rotation == 180
  end

  test "should return points for i shape" do
    points =
      new_brick(name: :i)
      |> points()

    assert {2, 2} in points
  end

  test "should return points for o shape" do
    points = new_brick(name: :o) |> points()
    assert {3, 3} in points
  end

  test "should return points for z shape" do
    points =
      new_brick(name: :z)
      |> points()

    assert {3, 4} in points
  end

  test "should return points for t shape" do
    points =
      new_brick(name: :t)
      |> points

    assert {2, 3} in points
  end

  test "should return points for l shape" do
    points =
      new_brick(name: :l)
      |> points

    assert {2, 2} in points
  end

  def new_brick(attributes \\ []), do: new(attributes)
end
