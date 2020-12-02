defmodule Day2 do

  def from_file(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_row/1)
  end

  def parse_row(row) do
    [min, max, letter, password] = Regex.run(~r{(\d+)-(\d+) (\w+): (\w+)}, row, capture: :all_but_first)
    {String.to_integer(min), String.to_integer(max), letter, password}
  end

  def valid_passwords_part1(passwords) do
    passwords
    |> Enum.filter(&valid_part1?/1)
  end

  def valid_part1?({min, max, letter, password}) do
    count = String.graphemes(password)
            |> Enum.filter(&(&1 == letter))
            |> Enum.count
    count >= min && count <= max
  end

  def valid_passwords_part2(passwords) do
    passwords
    |> Enum.filter(&valid_part2?/1)
  end

  def valid_part2?({pos1, pos2, letter, password}) do
    first = String.at(password, pos1 - 1) == letter
    second = String.at(password, pos2 - 1) == letter
    (first || second) && !(first && second)
  end

  def solution do
    IO.puts("#{from_file("day2_input.txt") |> valid_passwords_part1 |> length}")
    IO.puts("#{from_file("day2_input.txt") |> valid_passwords_part2 |> length}")
  end
end
