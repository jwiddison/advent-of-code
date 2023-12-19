defmodule AdventOfCode.2022.Day8 do
  @moduledoc """
  https://adventofcode.com/2022/day/8
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day8.part_1()
      0

  """
  @spec part_1() :: integer
  def part_1() do
    _grid = get_grid()
    0
  end

  @doc """
  Examples:

      iex> Day8.part_2()
      0

  """
  @spec part_2() :: integer
  def part_2() do
    0
  end

  defp get_grid() do
    8
    |> Inputs.read_file("2022")
    |> String.split("\n", trim: true)
  end
end
