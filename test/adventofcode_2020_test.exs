defmodule Adventofcode2020Test do
  use ExUnit.Case

  test "solves day 1 part 1" do
    input =
      """
      1721
      979
      366
      299
      675
      1456
      """
    numbers = input
              |> String.split("\n", trim: true)
              |> Enum.map(&Integer.parse/1)
              |> Enum.map(&(elem(&1, 0)))

    assert Day1.find_sum(numbers, 2020) |> Day1.multiply == 514579
  end

  test "solves day 1 part 2" do
    input =
      """
      1721
      979
      366
      299
      675
      1456
      """
    numbers = input
              |> String.split("\n", trim: true)
              |> Enum.map(&Integer.parse/1)
              |> Enum.map(&(elem(&1, 0)))

    assert Day1.find_sum_3(numbers, 2020) |> Day1.multiply == 241861950
  end

  test "solves day 2 part 1" do
    input =
    """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    """

    passwords = input
                |> String.split("\n", trim: true)
                |> Enum.map(&Day2.parse_row/1)

    assert Day2.valid_passwords_part1(passwords) |> length == 2
  end

  test "solves day 2 part 2" do
    input =
    """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    """

    passwords = input
                |> String.split("\n", trim: true)
                |> Enum.map(&Day2.parse_row/1)

    assert Day2.valid_passwords_part2(passwords) |> length == 1
  end
end