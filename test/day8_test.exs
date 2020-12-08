defmodule Day8Test do
  use ExUnit.Case

  import Day8
  alias Day8.Program

  test "solves day 8 part 1" do
    input =
    """
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
    """
    assert input |> parse |> Program.new |> Program.execute |> Map.get(:acc) == 5
  end

  test "solves day 8 part 2" do
    input =
    """
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
    """
    assert input |> parse |> Program.new |> find_op |> Map.get(:acc) == 8
  end

end