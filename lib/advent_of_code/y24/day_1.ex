defmodule AdventOfCode.Y24.Day1 do
  @moduledoc """
  https://adventofcode.com/2024/day/1
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day1.part_1()
      2_196_996

  """
  @spec part_1() :: integer
  def part_1() do
    {l, r} = get_lists()

    sorted_left = Enum.sort(l)
    sorted_right = Enum.sort(r)

    sorted_left
    |> Enum.zip(sorted_right)
    |> Enum.reduce(0, fn {x, y}, sum ->
      sum + abs(x - y)
    end)
  end

  @doc """
  Examples:

      iex> Day1.part_2()
      23_655_822

  """
  @spec part_2() :: integer
  def part_2() do
    {l, r} = get_lists()

    frequencies_map = Enum.frequencies(r)

    Enum.reduce(l, 0, fn item, acc ->
      case Map.get(frequencies_map, item) do
        nil -> acc
        frequency -> acc + item * frequency
      end
    end)
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

  @spec get_lists() :: tuple
  defp get_lists() do
    input = get_input()

    Enum.reduce(input, {[], []}, fn row, {left, right} ->
      [l, r] = String.split(row, "   ")
      new_left = [String.to_integer(l) | left] |> List.flatten()
      new_right = [String.to_integer(r) | right] |> List.flatten()

      {new_left, new_right}
    end)
  end
end
