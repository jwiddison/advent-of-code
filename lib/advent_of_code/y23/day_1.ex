defmodule AdventOfCode.Y23.Day1 do
  @moduledoc """
  https://adventofcode.com/2023/day/1
  """
  alias AdventOfCode.Helpers

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

  @word_nums %{
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
    inputs = get_input()

    Enum.reduce(inputs, 0, fn str, acc ->
      str
      |> parse_first_and_last_digit()
      |> Kernel.+(acc)
    end)
  end

  @doc """
  Examples:

      iex> Day1.part_2()
      54_985

  """
  @spec part_2() :: integer
  def part_2() do
    inputs = get_input()

    Enum.reduce(inputs, 0, fn str, acc ->
      str
      |> words_to_digits(@combinations)
      |> words_to_digits(@word_nums)
      |> parse_first_and_last_digit()
      |> Kernel.+(acc)
    end)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_input() :: list(String.t())
  defp get_input() do
    1
    |> Helpers.read_file("Y23")
    |> String.split("\n", trim: true)
  end

  @spec parse_first_and_last_digit(String.t()) :: integer
  defp parse_first_and_last_digit(str) do
    clean = String.replace(str, ~r/\D/, "")

    first = String.first(clean)
    last = String.last(clean)

    first
    |> Kernel.<>(last)
    |> Helpers.unsafe_string_to_integer()
  end

  @spec words_to_digits(String.t(), map) :: String.t()
  defp words_to_digits(str, words_to_digits_map) do
    Enum.reduce(words_to_digits_map, str, fn {words, digits}, acc ->
      String.replace(acc, words, digits)
    end)
  end
end
