defmodule AdventOfCode.2022.Day6 do
  @moduledoc """
  https://adventofcode.com/2022/day/6
  """
  alias AdventOfCode.Inputs

  @doc """
  Examples:

      iex> Day6.part_1()
      1_920

  """
  @spec part_1() :: integer
  def part_1() do
    sequence = get_sequence()

    find_start_marker(sequence, 4)
  end

  @doc """
  Examples:

      iex> Day6.part_2()
      2_334

  """
  @spec part_2() :: integer
  def part_2() do
    sequence = get_sequence()

    find_start_marker(sequence, 14)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec find_start_marker(String.t(), integer) :: integer
  defp find_start_marker(sequence, num_chars_to_check) do
    indices = 0..String.length(sequence)
    characters_list = String.graphemes(sequence)

    Enum.reduce_while(indices, 0, fn
      index, acc when index <= num_chars_to_check ->
        {:cont, acc + 1}

      index, acc ->
        uniq_chars_count =
          characters_list
          |> Enum.slice(index, num_chars_to_check)
          |> Enum.uniq()
          |> length()

        if uniq_chars_count == num_chars_to_check do
          {:halt, acc + num_chars_to_check}
        else
          {:cont, acc + 1}
        end
    end)
  end

  @spec get_sequence() :: String.t()
  defp get_sequence(), do: Inputs.read_file(6, "2022")
end
