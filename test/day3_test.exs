defmodule Day3Test do
  use ExUnit.Case

  def input() do
    """
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
    """
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  test "solves day 3 part 1" do
    assert input() |> Day3.grid |> Day3.traverse({3, 1}) |> Day3.trees == 7
  end

  test "solves day 3 part 2" do
    assert input() |> Day3.grid |> Day3.traverse([{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]) |> Day3.trees == 336
  end

end