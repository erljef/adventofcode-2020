defmodule Day3 do

  def from_file(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  def grid(rows) do
    %{rows: rows, path: [{0, 0}]}
  end

  def traverse(_, []), do: []
  def traverse(grid, [slope | tail]) do
    [traverse(grid, slope) | traverse(grid, tail)]
  end

  def traverse(%{rows: rows, path: [{_, y} | _]} = grid, {_, slope_y}) when y + slope_y > length(rows) - 1, do: grid
  def traverse(%{rows: _, path: [{x, y} | _]} = grid, {slope_x, slope_y} = slope) do
    %{grid | path: [ {x + slope_x, y + slope_y} | grid.path ]}
    |> traverse(slope)
  end

  def trees([_ | _] = grids) do
    grids
    |> Enum.map(&trees/1)
    |> Enum.reduce(1, &(&1 * &2))
  end

  def trees(%{rows: rows, path: path}) do
    for {x, y} <- path do
      row = Enum.at(rows, y)
      x_ = rem(x, length(row))
      case row |> Enum.at(x_) do
        ?# -> 1
        ?. -> 0
      end
    end
    |> Enum.reduce(&(&1 + &2))
  end

  def solution do
    IO.puts("#{from_file("day3_input.txt") |> grid |> traverse({3, 1}) |> trees}")
    IO.puts("#{from_file("day3_input.txt") |> grid |> traverse([{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]) |> trees}")
  end
end
