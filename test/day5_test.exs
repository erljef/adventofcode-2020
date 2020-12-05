defmodule Day5Test do
  use ExUnit.Case

  import Day5

  test "calculates position" do
    assert position("FBFBBFFRLR") == {44, 5}
    assert position("BFFFBBFRRR") == {70, 7}
    assert position("FFFBBBFRRR") == {14, 7}
    assert position("BBFFBBFRLL") == {102, 4}
  end

  test "calculates seat id" do
    assert seat({44, 5}) == 357
    assert seat({70, 7}) == 567
    assert seat({14, 7}) == 119
    assert seat({102, 4}) == 820
  end
end