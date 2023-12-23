defmodule AdventOfCode.Y22.Day1 do
  @moduledoc """
  https://adventofcode.com/2022/day/1
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day1.part_1()
      72_017

  """
  @spec part_1() :: integer
  def part_1() do
    list_of_totals = build_list_of_totals()
    Enum.max(list_of_totals)
  end

  @doc """
  Examples:

      iex> Day1.part_3()
      212_520

  """
  @spec part_3() :: integer
  def part_3() do
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
    1
    |> Helpers.read_file("Y22")
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
