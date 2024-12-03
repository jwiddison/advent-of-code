defmodule AdventOfCode.Y24.Day1 do
  @moduledoc """
  https://adventofcode.com/2024/day/1
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day1.part_1()
      1

  """
  @spec part_1() :: integer
  def part_1() do
    input = get_input()

    {l, r} =
      Enum.reduce(input, {[], []}, fn row, {left, right} ->
        [l, r] = String.split(row, "   ")
        new_left = [String.to_integer(l) | left] |> List.flatten()
        new_right = [String.to_integer(r) | right] |> List.flatten()

        {new_left, new_right}
      end)

    l
    |> Enum.sort()
    |> Enum.zip(Enum.sort(r))
    |> Enum.reduce(0, fn {x, y}, sum ->
      sum + abs(x - y)
    end)
  end

  @doc """
  Examples:

      iex> Day1.part_2()
      2

  """
  @spec part_2() :: integer
  def part_2() do
    2
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_input() :: list(String.t())
  defp get_input() do
    1
    |> Helpers.read_file("Y24")
    |> String.split("\n", trim: true)
  end
end
