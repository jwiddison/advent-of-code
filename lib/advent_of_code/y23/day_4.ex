defmodule AdventOfCode.Y23.Day4 do
  @moduledoc """
  https://adventofcode.com/2023/day/4
  """
  alias AdventOfCode.Inputs

  alias String.Break

  @doc """
  Examples:

      iex> Day4.part_1()
      23_235

  """
  @spec part_1() :: integer
  def part_1() do
    input = get_input()

    Enum.reduce(input, 0, fn card, total_score ->
      [_card_number, numbers] = String.split(card, ":")

      [winning_set, my_set] =
        numbers
        |> String.split(" |")
        |> Enum.map(&cards_string_to_mapset/1)

      common_nums =
        winning_set
        |> MapSet.intersection(my_set)
        |> Enum.count()

      # I can get away with just raising two to the power of the number of
      # matches, because 2^-1 (if there are none) is 0.5 and trunc/1 rounds
      # that down to 0
      2
      |> :math.pow(common_nums - 1)
      |> trunc()
      |> Kernel.+(total_score)
    end)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec cards_string_to_mapset(String.t()) :: MapSet.t()
  defp cards_string_to_mapset(str) do
    str
    |> Break.split()
    |> MapSet.new()
  end

  @spec get_input() :: list(String.t())
  defp get_input() do
    4
    |> Inputs.read_file("Y23")
    |> String.split("\n", trim: true)
  end
end
