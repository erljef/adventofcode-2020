defmodule Day1 do

  def from_file(path) do
    Helper.read_file(path)
    |> Enum.to_list
    |> List.flatten
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&(elem(&1, 0)))
  end

  def find_sum(numbers, value) do
    for x <- numbers,
        y <- numbers,
        x + y == value do
      {x, y}
    end
    |> List.first
  end

  def find_sum_3(numbers, value) do
    for x <- numbers,
        y <- numbers,
        z <- numbers,
        x + y + z == value do
      {x, y, z}
    end
    |> List.first
  end

  def multiply(tuple), do: tuple |> Tuple.to_list |> Enum.reduce(fn x, sum -> x * sum end)

  def solution do
    IO.puts("#{from_file("day1_input.txt") |> find_sum(2020) |> multiply}")
    IO.puts("#{from_file("day1_input.txt") |> find_sum_3(2020) |> multiply}")
  end
end
