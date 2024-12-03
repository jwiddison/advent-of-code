defmodule AdventOfCode.Y23.Day5 do
  @moduledoc """
  https://adventofcode.com/2023/day/5
  """
  alias AdventOfCode.Helpers

  @doc """
  Examples:

      iex> Day5.part_1()
      1

  """
  @spec part_1() :: integer
  def part_1() do
    [
      "seeds: " <> _seeds,
      "seed-to-soil map:\n" <> _seed_to_soil_map,
      "soil-to-fertilizer map:\n" <> _soil_to_fertilzer_map,
      "fertilizer-to-water map:\n" <> _fertilizer_to_water_map,
      "water-to-light map:\n" <> _water_to_light_map,
      "light-to-temperature map:\n" <> _light_to_temperature_map,
      "temperature-to-humidity map:\n" <> _temperature_to_humidity_map,
      "humidity-to-location map:\n" <> _humidity_to_location_map
    ] = get_input()

    # require IEx
    # IEx.pry()

    1
  end

  @doc """
  Examples:

      iex> Day5.part_2()
      1

  """
  @spec part_2() :: integer
  def part_2() do
    1
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_input() :: list(String.t())
  defp get_input() do
    5
    |> Helpers.read_file("Y23")
    |> String.split("\n\n", trim: true)
  end
end
