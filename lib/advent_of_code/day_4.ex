defmodule AdventOfCode.Day4 do
  @moduledoc """
  Advent of Code 2022, Day 34: Sunday December 3
  https://adventofcode.com/2022/day/4
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day4.part_1()
      0

  """
  @spec part_1() :: integer
  def part_1() do
    assignments = get_assignments()

    assignments
    |> Enum.filter(&assignments_overlap?/1)
    |> Enum.count()
  end

  @doc """
  Examples:

      iex> Day4.part_2()
      490

  """
  @spec part_2() :: integer
  def part_2() do
    assignments = get_assignments()

    assignments
    |> Enum.count()
  end

  ################################################################################
  # Private
  ################################################################################

  @spec assignment_to_mapset(String.t()) :: MapSet.t()
  defp assignment_to_mapset(assignment_string) do
    [left, right] = String.split(assignment_string, "-")
    {left_int, _rem} = Integer.parse(left)
    {right_int, _rem} = Integer.parse(right)
    MapSet.new(left_int..right_int)
  end

  @spec assignments_overlap?(String.t()) :: boolean
  defp assignments_overlap?(assignment_string) do
    [one, two] = String.split(assignment_string, ",")

    set_one = assignment_to_mapset(one)
    set_two = assignment_to_mapset(two)

    MapSet.subset?(set_one, set_two) || MapSet.subset?(set_two, set_one)
  end

  @spec get_assignments() :: list(String.t())
  defp get_assignments() do
    4
    |> Inputs.read_file()
    |> String.split("\n")
    |> Enum.drop(-1)
  end
end
