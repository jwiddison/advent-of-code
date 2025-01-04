defmodule AdventOfCode.Y24.Day2 do
  @moduledoc """
  https://adventofcode.com/2024/day/2
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day2.part_1()
      326

  """
  @spec part_1() :: integer
  def part_1() do
    input = parse_input()
    Enum.count(input, &safe?/1)
  end

  @doc """
  Examples:

      iex> Day2.part_2()
      381

  """
  @spec part_2() :: integer
  def part_2() do
    input = parse_input()

    Enum.count(input, fn row ->
      safe?(row) || safe_with_one_removed?(row)
    end)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec safe?(list) :: boolean
  defp safe?(row) do
    ordered?(row) && gaps_right_size?(row)
  end

  @spec safe_with_one_removed?(list) :: boolean
  defp safe_with_one_removed?(row) do
    0..(length(row) - 1)
    |> Enum.any?(fn index ->
      row
      |> List.delete_at(index)
      |> safe?()
    end)
  end

  @spec ordered?(list) :: boolean
  defp ordered?(list) do
    list == Enum.sort(list, :asc) || list == Enum.sort(list, :desc)
  end

  @spec gaps_right_size?(list) :: boolean
  defp gaps_right_size?(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] ->
      diff = abs(a - b)
      diff > 0 && diff < 4
    end)
  end

  @spec get_input() :: list
  defp get_input() do
    2
    |> Helpers.read_file("Y24")
    |> String.split("\n", trim: true)
  end

  @spec get_input() :: list
  defp parse_input() do
    input = get_input()

    Enum.map(input, fn row ->
      row
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
