defmodule AdventOfCode.Y23.Day1 do
  @moduledoc """
  https://adventofcode.com/2023/day/1
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day1.part_1()
      55_130

  """
  @spec part_1() :: integer
  def part_1() do
    get_calibrations()
    |> Enum.map(fn str ->
      # Clean out any non-digit characters
      clean = String.replace(str, ~r/\D/, "")

      case String.length(clean) do
        1 ->
          parse_and_sum_strings(clean, clean)

        _longer_than_one ->
          first = String.first(clean)
          last = String.last(clean)

          parse_and_sum_strings(first, last)
      end
    end)
    |> Enum.sum()
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_calibrations() :: list(String.t())
  defp get_calibrations() do
    1
    |> Inputs.read_file("Y23")
    |> String.split("\n", trim: true)
  end

  @spec parse_and_sum_strings(String.t(), String.t()) :: integer
  defp parse_and_sum_strings(str_1, str_2) do
    str_1
    |> Kernel.<>(str_2)
    |> Integer.parse()
    |> elem(0)
  end
end
