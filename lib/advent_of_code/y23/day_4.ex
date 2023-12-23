defmodule AdventOfCode.Y23.Day4 do
  @moduledoc """
  https://adventofcode.com/2023/day/4
  """
  alias AdventOfCode.Helpers

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
      num_matches = count_matches(numbers)

      # I can get away with just raising two to the power of the number of matches
      # minus one because 2^-1 (if there are none) is 0.5 and trunc/1 rounds that
      # down to 0
      2
      |> :math.pow(num_matches - 1)
      |> trunc()
      |> Kernel.+(total_score)
    end)
  end

  @doc """
  Examples:

      iex> Day4.part_2()
      5_920_640

  """
  @spec part_2() :: integer()
  def part_2() do
    input = get_input()
    length = length(input)

    Enum.reduce(input, %{}, fn card, map ->
      ["Card" <> card_number, numbers] = String.split(card, ":")
      num_matches = count_matches(numbers)

      current_card_index =
        card_number
        |> String.trim_leading()
        |> Helpers.unsafe_string_to_integer()

      # Defaulting to 0 in case we have no copies yet
      current_card_count = Map.get(map, current_card_index, 0)
      # Account for the original card, in addition to any copies we already have
      updated_card_count = current_card_count + 1

      map
      |> Map.put(current_card_index, updated_card_count)
      |> maybe_award_duplicate_cards(num_matches, updated_card_count, current_card_index)
    end)
    |> Map.values()
    |> Enum.take(length)
    |> Enum.sum()
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

  @spec count_matches(String.t()) :: integer
  defp count_matches(nums_string) do
    [winning_set, my_set] =
      nums_string
      |> String.split(" |")
      |> Enum.map(&cards_string_to_mapset/1)

    winning_set
    |> MapSet.intersection(my_set)
    |> Enum.count()
  end

  @spec get_input() :: list(String.t())
  defp get_input() do
    4
    |> Helpers.read_file("Y23")
    |> String.split("\n", trim: true)
  end

  @spec maybe_award_duplicate_cards(map, integer, integer, integer) :: map
  # If there were no matches, there are no duplicates to award
  defp maybe_award_duplicate_cards(map, 0, _card_copy_count, _current_card_index), do: map

  defp maybe_award_duplicate_cards(map, num_matches, card_copy_count, current_card_index) do
    # For however many matches I had on the current card, add 1 bonus card to each subsquent
    # "target" card for each copy of the current card I have
    Enum.reduce(1..num_matches, map, fn offset, map ->
      target_card = current_card_index + offset
      Map.update(map, target_card, card_copy_count, &Kernel.+(&1, card_copy_count))
    end)
  end
end
