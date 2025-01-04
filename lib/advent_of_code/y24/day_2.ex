defmodule AdventOfCode.Y24.Day2 do
  @moduledoc """
  https://adventofcode.com/2024/day/2
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day2.part_1()
      326

  """
  @spec part_1() :: integer
  def part_1() do
    input = parse_input()

    Enum.count(input, fn row ->
      is_ordered(row) && gaps_right_size(row)
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

  @spec is_ordered(list) :: boolean
  defp is_ordered(list) do
    list == Enum.sort(list, :asc) ||
      list == Enum.sort(list, :desc)
  end

  @spec gaps_right_size(list) :: boolean
  defp gaps_right_size(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] ->
      diff = abs(a - b)
      diff > 0 && diff < 4
    end)
  end

  @spec get_input() :: list
  defp get_input() do
    2
    |> Helpers.read_file("Y24")
    |> String.split("\n", trim: true)
  end

  @spec get_input() :: list
  defp parse_input() do
    input = get_input()

    Enum.map(input, fn row ->
      row
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
