defmodule Day4 do

  def from_file(path) do
    File.read!(path)
  end

  def parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_passport/1)
  end

  def parse_passport(passport) do
    passport
    |> String.split(~r/\s+/, trim: true)
    |> Enum.map(&String.split(&1, ":"))
    |> Map.new(fn [k, v] -> {k, v} end)
  end

  def valid(passports) do
    passports
    |> Enum.filter(&has_keys?/1)
    |> Enum.filter(&valid?/1)
  end

  def has_keys?(%{} = passport) do
    ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    |> Enum.all?(fn k -> Map.has_key?(passport, k) end)
  end

  def valid?(%{"byr" => byr, "iyr" => iyr, "eyr" => eyr, "hgt" => hgt, "hcl" => hcl, "ecl" => ecl, "pid" => pid}) do
    String.to_integer(byr) in 1920..2002
    && String.to_integer(iyr) in 2010..2020
    && String.to_integer(eyr) in 2020..2030
    && valid_height?(hgt)
    && valid_colorcode?(hcl)
    && valid_color?(ecl)
    && valid_pid?(pid)
  end

  def valid_height?(hgt) do
    [h, unit] = Regex.run(~r{(\d+)(\w+)}, hgt, capture: :all_but_first)
    case [h |> String.to_integer, unit] do
      [h, "cm"] -> h in 150..193
      [h, "in"] -> h in 59..76
      _ -> false
    end
  end

  def valid_colorcode?(hcl) do
    Regex.match?(~r/^#[0-9a-f]{6}$/, hcl)
  end

  def valid_color?(ecl), do: ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  def valid_pid?(pid) do
    Regex.match?(~r/^\d{9}$/, pid)
  end

  def solution do
    IO.puts("#{from_file("day4_input.txt") |> parse |> Enum.filter(&has_keys?/1) |> length}")
    IO.puts("#{from_file("day4_input.txt") |> parse |> valid |> length}")
  end
end
