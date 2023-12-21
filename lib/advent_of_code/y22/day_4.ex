defmodule AdventOfCode.Y22.Day4 do
  @moduledoc """
  https://adventofcode.com/2022/day/4
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day4.part_1()
      490

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
      921

  """
  @spec part_2() :: integer
  def part_2() do
    assignments = get_assignments()

    assignments
    |> Enum.filter(&assignments_intersect?/1)
    |> Enum.count()
  end

  ################################################################################
  # Private
  ################################################################################

  @spec assignment_to_mapset(String.t()) :: MapSet.t()
  defp assignment_to_mapset(assignment_string) do
    assignment_string
    |> String.replace("-", "..")
    |> Code.eval_string()
    |> elem(0)
    |> MapSet.new()
  end

  @spec assignments_intersect?(String.t()) :: boolean
  def assignments_intersect?(assignment) do
    [set_one, set_two] = map_assignment(assignment)

    set_one
    |> MapSet.intersection(set_two)
    |> MapSet.size()
    |> Kernel.>(0)
  end

  @spec assignments_overlap?(String.t()) :: boolean
  defp assignments_overlap?(assignment) do
    [set_one, set_two] = map_assignment(assignment)

    MapSet.subset?(set_one, set_two) || MapSet.subset?(set_two, set_one)
  end

  @spec get_assignments() :: list(String.t())
  defp get_assignments() do
    4
    |> Inputs.read_file("Y22")
    |> String.split("\n", trim: true)
  end

  @spec map_assignment(String.t()) :: list(MapSet.t())
  defp map_assignment(assignments_string) do
    assignments_string
    |> String.split(",")
    |> Enum.map(&assignment_to_mapset/1)
  end
end
