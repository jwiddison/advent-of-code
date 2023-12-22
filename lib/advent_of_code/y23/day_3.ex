defmodule AdventOfCode.Y23.Day3 do
  @moduledoc """
  https://adventofcode.com/2023/day/3
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day3.part_1()
      1

  """
  @spec part_1() :: integer
  def part_1() do
    _input = get_input()
    1
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_input() :: list(String.t())
  defp get_input() do
    3
    |> Inputs.read_file("Y23")
    |> String.split("\n", trim: true)
  end
end
