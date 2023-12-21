defmodule AdventOfCode.Y23.Day1 do
  @moduledoc """
  https://adventofcode.com/2023/day/1
  """
  alias AdventOfCode.Inputs

  @combinations %{
    "oneight" => "18",
    "twone" => "21",
    "threeight" => "38",
    "fiveight" => "58",
    "sevenine" => "79",
    "eightwo" => "82",
    "eighthree" => "83",
    "nineight" => "98"
  }

  @string_nums %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  @doc """
  Examples:

      iex> Day1.part_1()
      55_130

  """
  @spec part_1() :: integer
  def part_1() do
    input = get_input()

    Enum.reduce(input, 0, fn str, acc ->
      acc + sum_first_and_last_digit(str)
    end)
  end

  @doc """
  Examples:

      iex> Day1.part_2()
      54_985

  """
  @spec part_2() :: integer
  def part_2() do
    input = get_input()

    Enum.reduce(input, 0, fn str, acc ->
      clean_str =
        str
        |> cleanup_words(@combinations)
        |> cleanup_words(@string_nums)

      acc + sum_first_and_last_digit(clean_str)
    end)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec cleanup_words(String.t(), map) :: String.t()
  defp cleanup_words(str, words_to_digits_map) do
    Enum.reduce(words_to_digits_map, str, fn {words, digits}, acc ->
      String.replace(acc, words, digits)
    end)
  end

  @spec concat_and_parse_strings(String.t(), String.t()) :: integer
  defp concat_and_parse_strings(str_1, str_2) do
    str_1
    |> Kernel.<>(str_2)
    |> Integer.parse()
    |> elem(0)
  end

  @spec get_input() :: list(String.t())
  defp get_input() do
    1
    |> Inputs.read_file("Y23")
    |> String.split("\n", trim: true)
  end

  @spec sum_first_and_last_digit(String.t()) :: integer
  defp sum_first_and_last_digit(str) do
    # Clean out any non-digit characters
    clean = String.replace(str, ~r/\D/, "")

    case String.length(clean) do
      1 ->
        # If it's only one character, that character is BOTH the first and last digit
        concat_and_parse_strings(clean, clean)

      _longer_than_one ->
        # I'm sure there's a better way to grab a string's first and last chars
        first = String.first(clean)
        last = String.last(clean)

        concat_and_parse_strings(first, last)
    end
  end
end
