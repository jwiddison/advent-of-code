defmodule AdventOfCode.One do
  @moduledoc """
  Thursday December 1
  https://adventofcode.com/2022/day/1
  """
  @path_to_input "lib/advent_of_code/one/one_input.txt"

  @doc """
  Examples:

      iex> One.run()
      iex> 72_017

  """
  @spec run() :: integer
  def run() do
    @path_to_input
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.drop(-1)
    |> Enum.map(&parse_and_sum_list/1)
    |> Enum.max()
  end

  ################################################################################
  # Private
  ################################################################################

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
