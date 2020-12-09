defmodule Day9Test do
  use ExUnit.Case

  import Day9

  test "solves day 9 part 1" do
    input =
    """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    assert input |> parse |> find_invalid(5) |> elem(0) == 127
  end

  test "solves day 9 part 2" do
    input =
    """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    assert input |> parse |> find_set(127) |> weakness == 62
  end

end