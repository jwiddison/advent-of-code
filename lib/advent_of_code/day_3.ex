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
    |> Enum.map(&find_and_prioritize_item/1)
    |> Enum.sum()
  end

  @doc """
  Examples:

      iex> Day3.part_2()
      2_479

  """
  @spec part_2() :: integer
  def part_2() do
    rucksacks = get_rucksacks()

    rucksacks
    |> Enum.chunk_every(3)
    |> Enum.map(&find_and_prioritize_group_badge/1)
    |> Enum.sum()
  end

  ################################################################################
  # Private
  ################################################################################

  @spec find_and_prioritize_item(String.t()) :: integer
  defp find_and_prioritize_item(rucksack_string) do
    half_size =
      rucksack_string
      |> String.length()
      |> div(2)

    {half_1, half_2} = String.split_at(rucksack_string, half_size)

    set_1 = string_to_mapset(half_1)
    set_2 = string_to_mapset(half_2)

    set_1
    |> MapSet.intersection(set_2)
    |> Enum.to_list()
    |> hd()
    |> priority_for_letter()
  end

  @spec find_and_prioritize_group_badge(list(String.t())) :: integer
  def find_and_prioritize_group_badge([elf_1, elf_2, elf_3]) do
    set_1 = string_to_mapset(elf_1)
    set_2 = string_to_mapset(elf_2)
    set_3 = string_to_mapset(elf_3)

    set_1
    |> MapSet.intersection(set_2)
    |> MapSet.intersection(set_3)
    |> Enum.to_list()
    |> hd()
    |> priority_for_letter()
  end

  @spec get_rucksacks() :: list(String.t())
  defp get_rucksacks() do
    3
    |> Inputs.read_file()
    |> String.split("\n")
    |> Enum.drop(-1)
  end

  @spec priority_for_letter(letter :: String.t()) :: priority :: integer
  defp priority_for_letter(letter) do
    <<ascii_num::utf8>> = letter

    if String.downcase(letter) == letter do
      ascii_num - 96
    else
      ascii_num - 38
    end
  end

  @spec string_to_mapset(String.t()) :: MapSet.t()
  defp string_to_mapset(string) do
    string
    |> String.graphemes()
    |> MapSet.new()
  end
end
