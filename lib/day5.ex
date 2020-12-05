defmodule Day5 do

  def from_file(path) do
    File.read!(path)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&position/1)
  end

  def position(code) do
    code
    |> String.split_at(7)
    |> Tuple.to_list
    |> Enum.map(&convert/1)
    |> Enum.map(fn bin -> String.to_integer(bin, 2) end)
    |> List.to_tuple
  end

  def convert(code) do
    code
    |> String.replace("F", "0")
    |> String.replace("B", "1")
    |> String.replace("L", "0")
    |> String.replace("R", "1")
  end

  def seat({r, c}), do: r * 8 + c

  def missing_seat(seats) do
    [[a, _]] = seats
    |> Enum.sort
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.filter(fn [a, b] -> b - a == 2 end)

    a + 1
  end

  def solution do
    IO.puts("#{from_file("day5_input.txt") |> parse |> Enum.map(&seat/1) |> Enum.max}")
    IO.puts("#{from_file("day5_input.txt") |> parse |> Enum.map(&seat/1) |> missing_seat}")
  end
end
