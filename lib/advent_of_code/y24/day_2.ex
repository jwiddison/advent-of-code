defmodule AdventOfCode.Y24.Day2 do
  @moduledoc """
  https://adventofcode.com/2024/day/2
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day2.part_1()
      1

  """
  @spec part_1() :: integer
  def part_1() do
    parsed = parse_input()

    Enum.reduce(parsed, 0, fn _row, _acc ->
      nil
    end)

    1
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

  # @spec check_increasing_or_decreasing(list) :: boolean
  # defp check_increasing_or_decreasing(list) do
  #   list == Enum.sort(list, :asc) ||
  #     list == Enum.sort(list, :desc)
  # end

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
