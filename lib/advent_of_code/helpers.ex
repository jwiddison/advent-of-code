defmodule AdventOfCode.Helpers do
  @moduledoc """
  Helper for reading the input files
  """

  @spec read_file(day_number :: integer, year :: String.t()) :: file_contents :: binary
  def read_file(day_number, year) do
    file = "lib/advent_of_code/#{year}/inputs/#{day_number}.txt"
    File.read!(file)
  end

  @spec unsafe_string_to_integer(String.t()) :: integer
  def unsafe_string_to_integer(str) do
    str
    |> Integer.parse()
    |> elem(0)
  end
end
