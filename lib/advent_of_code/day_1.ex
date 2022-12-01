defmodule AdventOfCode.Day1 do
  @moduledoc """
  Advent of Code 2022, Day 1: Thursday December 1
  https://adventofcode.com/2022/day/1
  """
  @path_to_input "lib/advent_of_code/day_1/day_1_input.txt"

  @doc """
  Examples:

      iex> Day1.get_max()
      iex> 72_017

  """
  @spec get_max() :: integer
  def get_max() do
    list_of_totals = build_list_of_totals()
    Enum.max(list_of_totals)
  end

  @doc """
  Examples:

      iex> Day1.sum_top_three()
      iex> 212_520

  """
  @spec sum_top_three() :: integer
  def sum_top_three() do
    list_of_totals = build_list_of_totals()

    list_of_totals
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  ################################################################################
  # Private
  ################################################################################

  @spec build_list_of_totals() :: list(integer)
  defp build_list_of_totals() do
    @path_to_input
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&parse_and_sum_list/1)
  end

  @spec parse_and_sum_list(String.t()) :: integer
  defp parse_and_sum_list(string_list) do
    string_list
    |> String.split("\n")
    |> Enum.map(&safe_integer_parse/1)
    |> Enum.sum()
  end

  @spec safe_integer_parse(String.t()) :: integer
  defp safe_integer_parse(string_int) do
    case Integer.parse(string_int, 10) do
      {x, _rem} -> x
      _other -> 0
    end
  end
end
