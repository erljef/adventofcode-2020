defmodule Day6 do

  def from_file(path) do
    File.read!(path)
  end

  def parse(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end

  def sum_anyone(groups) do
    groups
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&length/1)
    |> Enum.sum
  end

  def sum_everyone(groups) do
    groups
    |> Enum.map(&everyone/1)
    |> Enum.sum
  end

  def everyone(group) do
    group
    |> Enum.map(&String.graphemes/1)
    |> List.flatten
    |> Enum.frequencies
    |> Map.to_list
    |> Enum.filter(fn {_, count} -> count == length(group) end)
    |> Enum.count
  end

  def solution do
    IO.puts("#{from_file("day6_input.txt") |> parse |> sum_anyone}")
    IO.puts("#{from_file("day6_input.txt") |> parse |> sum_everyone}")
  end
end
