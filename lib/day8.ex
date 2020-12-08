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

  def find_op(program) do
    program.program
    |> Enum.filter(fn {_, {op, _}} -> op != :acc end)
    |> Enum.map(fn {ix, _} -> Program.switch_op(program, ix) end)
    |> Enum.map(&Program.execute/1)
    |> Enum.find(&(&1.terminated))
  end

  def solution do
    IO.puts("#{from_file("day8_input.txt") |> parse |> Program.new |> Program.execute |> Map.get(:acc)}")
    IO.puts("#{from_file("day8_input.txt") |> parse |> Program.new |> find_op |> Map.get(:acc)}")
  end

  defmodule Program do
    defstruct acc: 0,
              history: MapSet.new,
              pc: 0,
              program: %{},
              infinite: false,
              terminated: false

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
          %{state | infinite: true}

        !Map.has_key?(state.program, state.pc) ->
          %{state | terminated: true}

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

    def switch_op(state, index), do: state |> switch_op(index, Map.get(state.program, index))
    def switch_op(state, index, {"jmp", arg}), do: %{state | program: state.program |> Map.replace(index, {"nop", arg})}
    def switch_op(state, index, {"nop", arg}), do: %{state | program: state.program |> Map.replace(index, {"jmp", arg})}
    def switch_op(state, _, _), do: state

  end
end
