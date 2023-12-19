defmodule AdventOfCode.Inputs do
  @moduledoc """
  Helper for reading the input files
  """

  @spec read_file(day_number :: integer, year :: String.t()) :: file_contents :: binary
  def read_file(day_number, year) do
    file = "lib/advent_of_code/#{year}/inputs/#{day_number}.txt"
    File.read!(file)
  end
end
