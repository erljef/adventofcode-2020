defmodule Day7 do
  require Graph

  def from_file(path) do
    File.read!(path)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> Regex.run(~r/(.*) bags contain (.*)\./, x, capture: :all_but_first) end)
    |> Enum.map(fn [type, contains] -> [type, parse_contains(contains)] end)
    |> Map.new(fn [k, v] -> {k, v} end)
  end

  def parse_contains(contains) do
    contains
    |> String.split(", ")
    |> Enum.map(&(Regex.run(~r/(\d+) (.+) bag/, &1, capture: :all_but_first)))
    |> Enum.filter(&(&1 != nil))
    |> Map.new(fn [k, v] -> {v, k} end)
  end

  def to_graph(map) do
    map
    |> Map.to_list
    |> Enum.map(fn {k, v} -> Enum.zip(Stream.cycle([k]), Map.keys(v) |> Enum.map(fn k -> {k, Map.get(v, k)} end)) end)
    |> Enum.filter(fn v -> !Enum.empty?(v) end)
    |> List.flatten
    |> Enum.reduce(Graph.new, fn {v1, {v2, w}}, g -> Graph.add_edge(g, v1, v2, weight: String.to_integer(w)) end)
  end

  def can_contain(graph, bag) do
    graph
    |> Graph.reaching([bag])
    |> Enum.filter(&(&1 != bag))
  end

  def contains(graph, bag) do
    paths(graph, bag)
    |> Enum.map(&bags/1)
    |> Enum.map(&sum/1)
    |> List.flatten
    |> Enum.sum
  end

  def paths(graph, bag) do
    graph
    |> Graph.out_edges(bag)
    |> Enum.map(fn %{v2: v, weight: w} -> {v, w} end)
    |> Enum.map(fn {v, w} -> [{v, w} | paths(graph, v)] end)
  end

  def bags([{_, w} | paths]) do
    [w | paths |> Enum.map(&bags/1)]
  end

  def sum([w1 | bags]) do
    [w1 | bags |> Enum.map(fn [w2 | tail] -> sum([w1 * w2 | tail]) end)]
  end

  def solution do
    IO.puts("#{from_file("day7_input.txt") |> parse |> to_graph |> can_contain("shiny gold") |> length}")
    IO.puts("#{from_file("day7_input.txt") |> parse |> to_graph |> contains("shiny gold")}")
  end
end
