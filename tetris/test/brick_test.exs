defmodule BrickTest do
  use ExUnit.Case

  import Tetris.Brick
  alias Tetris.Points

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

  test "should translate a list of points" do
    actual_points =
      new_brick()
      |> points()
      |> Points.translate({1, 1})

    assert actual_points == [{3, 2}, {3, 3}, {3, 4}, {3, 5}]
  end

  test "should flip, rotate and mirror" do
    [{1, 1}]
    |> Points.mirror()
    |> assert_point({4, 1})
    |> Points.flip()
    |> assert_point({4, 4})
    |> Points.rotate_90()
    |> assert_point({1, 4})
    |> Points.rotate_90()
    |> assert_point({1, 1})
  end

  def new_brick(attributes \\ []), do: new(attributes)

  def assert_point([actual], expected) do
    assert actual == expected
    [actual]
  end
end
