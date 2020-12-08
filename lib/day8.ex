defmodule Day8 do
  alias Day8.Program

  def from_file(path) do
    File.read!(path)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [op, arg] -> {op, String.to_integer(arg)} end)
    |> Enum.zip(Stream.iterate(0, &(&1 + 1)))
    |> Enum.map(fn {op, ix} -> {ix, op} end)
    |> Map.new
  end

  def solution do
    IO.puts("#{from_file("day8_input.txt") |> parse |> Program.new |> Program.execute |> Map.get(:acc)}")
  end

  defmodule Program do
    defstruct acc: 0,
              history: MapSet.new,
              pc: 0,
              program: %{}

    def new(%{} = input) do
      %Program{program: input}
    end

    def add_history(state, index) do
      %{state | history: state.history |> MapSet.put(index)}
    end

    def increase_pc(state, value) do
      %{state | pc: state.pc + value}
    end

    def execute(%Program{} = state) do
      cond do
        state.pc in state.history ->
          state

        op = Map.get(state.program, state.pc) ->
          execute(state, op)
          |> add_history(state.pc)
          |> execute
      end
    end

    def execute(state, {"acc", arg}) do
      %{state | acc: state.acc + arg}
      |> increase_pc(1)
    end

    def execute(state, {"jmp", arg}) do
      state
      |> increase_pc(arg)
    end

    def execute(state, {"nop", _}) do
      state
      |> increase_pc(1)
    end

  end
end
