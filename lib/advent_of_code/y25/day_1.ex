defmodule AdventOfCode.Y25.Day1 do
  @moduledoc """
  https://adventofcode.com/2025/day/1
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day1.part_1()
      1_052

  """
  @spec part_1() :: integer
  def part_1() do
    get_input()
    |> Enum.reduce({50, 0}, fn new_move, {previous_position, zero_count} ->
      new_position = Integer.mod(previous_position + new_move, 100)
      new_zero_count = if new_position == 0, do: zero_count + 1, else: zero_count
      {new_position, new_zero_count}
    end)
    |> elem(1)
  end

  @doc """
  Examples:

      iex> Day1.part_2()
      6_295

  """
  @spec part_2() :: integer
  def part_2() do
    get_input()
    |> Enum.reduce({50, 0}, fn new_move, {previous_position, zero_count} ->
      # check for full rotatitions first
      zero_count = zero_count + abs(div(new_move, 100))

      # check if current rotation goes past zero, but didn't start at 0
      after_full_rotations = rem(new_move, 100)
      new_position_before_mod = previous_position + after_full_rotations

      zero_count =
        if previous_position != 0 && (new_position_before_mod > 100 || new_position_before_mod < 0) do
          zero_count + 1
        else
          zero_count
        end

      # check if we landed on zero
      new_position = Integer.mod(new_position_before_mod, 100)
      zero_count = if new_position == 0, do: zero_count + 1, else: zero_count

      {new_position, zero_count}
    end)
    |> elem(1)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_input() :: list(integer)
  defp get_input() do
    1
    |> Helpers.read_file("Y25")
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "R" <> steps -> String.to_integer(steps)
      "L" <> steps -> -String.to_integer(steps)
    end)
  end
end
