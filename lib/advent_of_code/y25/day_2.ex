defmodule AdventOfCode.Y25.Day2 do
  @moduledoc """
  https://adventofcode.com/2025/day/2
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day2.part_1()
      29_818_212_493

  """
  @spec part_1() :: integer
  def part_1() do
    Enum.reduce(get_input(), 0, fn range, acc ->
      acc + sum_invalid_ids_in_range(range)
    end)
  end

  @doc """
  Examples:

      iex> Day2.part_2()
      2

  """
  @spec part_2() :: integer
  def part_2() do
    2
  end

  ################################################################################
  # Private
  ################################################################################

  defp sum_invalid_ids_in_range(range) do
    Enum.reduce(range, 0, fn int, acc ->
      if int_has_two_equal_halves?(int),
        do: acc + int,
        else: acc
    end)
  end

  defp int_has_two_equal_halves?(int) do
    str = Integer.to_string(int)

    half_length =
      str
      |> String.length()
      |> div(2)

    case String.split_at(str, half_length) do
      {same, same} -> true
      _ -> false
    end
  end

  defp get_input() do
    2
    |> Helpers.read_file("Y25")
    |> String.trim("\n")
    |> String.split(",", trim: true)
    |> Enum.map(fn str ->
      [l, r] = String.split(str, "-")
      String.to_integer(l)..String.to_integer(r)
    end)
  end
end
