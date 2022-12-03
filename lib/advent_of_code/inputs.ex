defmodule AdventOfCode.Inputs do
  @moduledoc """
  Helper for reading the input files
  """

  @spec read_file(day_number :: integer) :: file_contents :: binary
  def read_file(day_number) do
    file = "lib/advent_of_code/inputs/#{day_number}.txt"
    File.read!(file)
  end
end
