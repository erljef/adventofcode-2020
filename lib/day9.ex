defmodule Day9 do

  def from_file(path) do
    File.read!(path)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def find_invalid(numbers, size) do
    indexed = Enum.with_index(numbers)

    indexed
    |> Enum.drop(size)
    |> Enum.find(fn v -> !valid?(indexed, size, v) end)
  end

  def valid?(numbers, size, {number, index}) do
    numbers
    |> Enum.slice(index - size, size)
    |> Enum.map(fn {v, _} -> v end)
    |> find_sum(number)
    != nil
  end

  def find_sum(numbers, value) do
    for x <- numbers,
        y <- numbers,
        x + y == value do
      {x, y}
    end
    |> List.first
  end

  def find_set(numbers, value) do
    numbers
    |> Enum.with_index
    |> Enum.map(fn {_, ix} -> sum_while(numbers |> Enum.drop(ix), value) end)
    |> Enum.filter(fn l -> !Enum.empty?(l) end)
    |> List.first
  end

  def sum_while(numbers, target) do
    numbers
    |> Enum.reduce_while([], fn v, acc ->
      cond do
        Enum.sum(acc) < target ->
          {:cont, [v | acc]}

        Enum.sum(acc) == target ->
          {:halt, acc}

        Enum.sum(acc) > target ->
          {:halt, []}
      end
    end)
  end

  def weakness(set) do
    Enum.min(set) + Enum.max(set)
  end

  def solution do
    input = from_file("day9_input.txt") |> parse
    invalid = input |> find_invalid(25) |> elem(0)
    IO.puts("#{invalid}")
    IO.puts("#{input |> find_set(invalid) |> weakness}")
  end

end
