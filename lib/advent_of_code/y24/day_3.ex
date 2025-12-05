defmodule AdventOfCode.Y24.Day3 do
  @moduledoc """
  https://adventofcode.com/2024/day/3
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day3.part_1()
      1

  """
  @spec part_1() :: integer
  def part_1() do
    _input = get_input()
    # IO.inspect(input)
    1
  end

  @doc """
  Examples:

      iex> Day3.part_2()
      2

  """
  @spec part_2() :: integer
  def part_2() do
    2
  end

  ################################################################################
  # Private
  ################################################################################

  defp get_input() do
    3
    |> Helpers.read_file("Y24")
  end
end
