defmodule Day6Test do
  use ExUnit.Case

  import Day6

  test "calculates the sum of questions anyone answered yes" do
    input =
    """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """
    assert input |> parse |> sum_anyone == 11
  end

  test "calculates the sum of questions everyone answered yes" do
    input =
    """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """
    assert input |> parse |> sum_everyone == 6
  end

end