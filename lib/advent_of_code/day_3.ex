defmodule AdventOfCode.Day3 do
  @moduledoc """
  Advent of Code 2022, Day 3: Saturday December 3
  https://adventofcode.com/2022/day/3
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day3.part_1()
      7_875

  """
  @spec part_1() :: integer
  def part_1() do
    rucksacks = get_rucksacks()

    rucksacks
    |> Enum.map(&find_and_prioritize_mismatch/1)
    |> Enum.sum()
  end

  ################################################################################
  # Private
  ################################################################################

  @spec find_and_prioritize_mismatch(String.t()) :: integer
  def find_and_prioritize_mismatch(rucksack_string) do
    half_size =
      rucksack_string
      |> String.length()
      |> Kernel./(2)
      |> Kernel.trunc()

    {first_half, second_half} =
      rucksack_string
      |> String.graphemes()
      |> Enum.split(half_size)

    first_half_set = MapSet.new(first_half)
    second_half_set = MapSet.new(second_half)

    mismatch =
      first_half_set
      |> MapSet.intersection(second_half_set)
      |> Enum.to_list()
      |> hd()

    <<ascii_num::utf8>> = mismatch

    if String.downcase(mismatch) == mismatch do
      ascii_num - 96
    else
      ascii_num - 38
    end
  end

  @spec get_rucksacks() :: list(String.t())
  defp get_rucksacks() do
    3
    |> Inputs.read_file()
    |> String.split("\n")
    |> Enum.drop(-1)
  end
end
