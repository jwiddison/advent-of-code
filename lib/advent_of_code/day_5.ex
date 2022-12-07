defmodule AdventOfCode.Day5 do
  @moduledoc """
  Advent of Code 2022, Day 5: Monday December 5
  https://adventofcode.com/2022/day/5
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day5.part_1()
      "SHMSDGZVC"

  """
  @spec part_1() :: String.t()
  def part_1() do
    instructions = get_instructions()
    starting_stacks = starting_stacks()

    instructions
    |> Enum.reduce(starting_stacks, &handle_move/2)
    |> get_last_items()
  end

  @doc """
  Examples:

      iex> Day5.part_2()
      "VRZGHDFBQ"

  """
  @spec part_2() :: String.t()
  def part_2() do
    instructions = get_instructions()
    starting_stacks = starting_stacks()

    instructions
    |> Enum.reduce(starting_stacks, &handle_move(&1, &2, false))
    |> get_last_items()
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_instructions() :: list(String.t())
  defp get_instructions() do
    5
    |> Inputs.read_file()
    |> String.split("\n\n")
    |> Enum.at(1)
    |> String.split("\n", trim: true)
  end

  @spec get_last_items(map) :: String.t()
  defp get_last_items(stacks_map) do
    Enum.reduce(stacks_map, "", fn {_key, stack}, acc ->
      acc <> List.last(stack)
    end)
  end

  @spec handle_move(String.t(), map, boolean) :: map
  defp handle_move(instruction_string, stacks, one_at_a_time \\ true) do
    %{count: count, destination: destination, origin: origin} = parse_instruction(instruction_string)

    origin_stack = Map.get(stacks, origin)
    destination_stack = Map.get(stacks, destination)

    {new_origin, to_move} = Enum.split(origin_stack, -count)

    new_destination =
      if one_at_a_time do
        destination_stack ++ Enum.reverse(to_move)
      else
        destination_stack ++ to_move
      end

    stacks
    |> Map.put(origin, new_origin)
    |> Map.put(destination, new_destination)
  end

  @spec parse_instruction(String.t()) :: map
  defp parse_instruction(instruction_string) do
    [_move, count, _from, origin, _to, destination] = String.split(instruction_string)

    {count_int, _rem} = Integer.parse(count)
    {origin_int, _rem} = Integer.parse(origin)
    {destination_int, _rem} = Integer.parse(destination)

    %{
      count: count_int,
      destination: destination_int,
      origin: origin_int
    }
  end

  # Hard coded 'cause I AM BEHIND AND I HAVE NO TIME
  @spec starting_stacks() :: map
  def starting_stacks() do
    %{
      1 => ["D", "T", "R", "B", "J", "L", "W", "G"],
      2 => ["S", "W", "C"],
      3 => ["R", "Z", "T", "M"],
      4 => ["D", "T", "C", "H", "S", "P", "V"],
      5 => ["G", "P", "T", "L", "D", "Z"],
      6 => ["F", "B", "R", "Z", "J", "Q", "C", "D"],
      7 => ["S", "B", "D", "J", "M", "F", "T", "R"],
      8 => ["L", "H", "R", "B", "T", "V", "M"],
      9 => ["Q", "P", "D", "S", "V"]
    }
  end
end
