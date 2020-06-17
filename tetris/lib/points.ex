defmodule Tetris.Points do
  def translate(points, {x, y}) do
    Enum.map(points, fn {dx, dy} -> {dx + x, dy + y} end)
  end

  def transpose(points) do
    points
    |> Enum.map(fn {x, y} -> {y, x} end)
  end

  def mirror(points) do
    points
    |> Enum.map(fn {x, y} -> {5 - x, y} end)
  end

  def mirror(points, false), do: points
  def mirror(points, true), do: mirror(points)

  def flip(points) do
    points
    |> Enum.map(fn {x, y} -> {x, 5 - y} end)
  end

  def rotate_90(points) do
    points
    |> transpose()
    |> mirror()
  end

  def rotate(points, 0), do: points

  def rotate(points, degrees) do
    rotate(
      rotate_90(points),
      degrees - 90
    )
  end

  def to_string(points) do
    map =
      points
      |> Enum.map(fn key -> {key, ":black_small_square:"} end)
      |> Map.new()

    for y <- 1..4, x <- 1..4 do
      Map.get(map, {x, y}, ":white_small_square:")
    end
    |> Enum.chunk_every(4)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  def print(points) do
    IO.puts(__MODULE__.to_string(points))
    points
  end
end
