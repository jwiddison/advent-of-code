defmodule AdventOfCode.Y23.Day2 do
  @moduledoc """
  https://adventofcode.com/2023/day/2
  """
  alias AdventOfCode.Helpers

  defmodule RGB do
    @moduledoc false

    alias __MODULE__

    @enforce_keys [:red, :green, :blue]
    defstruct @enforce_keys

    @type t :: %__MODULE__{}

    @spec new() :: t
    def new(), do: %RGB{red: 0, green: 0, blue: 0}

    @spec merge(t, String.t(), integer) :: t
    def merge(
          struct = %RGB{},
          color,
          new_val
        ) do
      atom_color = String.to_existing_atom(color)
      old_val = Map.get(struct, atom_color)
      max_val = max(new_val, old_val)
      Map.put(struct, atom_color, max_val)
    end

    @spec draws_are_possible?(t, t) :: boolean
    def draws_are_possible?(
          %RGB{red: drawn_red, green: drawn_green, blue: drawn_blue},
          %RGB{red: actual_red, green: actual_green, blue: actual_blue}
        ) do
      actual_red >= drawn_red && actual_green >= drawn_green && actual_blue >= drawn_blue
    end
  end

  @doc """
  Examples:

      iex> Day2.part_1()
      2_727

  """
  @spec part_1() :: integer
  def part_1() do
    input = get_input()

    # Requirements from the problem
    max_required = %RGB{red: 12, green: 13, blue: 14}

    Enum.reduce(input, 0, fn game, acc ->
      ["Game " <> game_number, game_text] = String.split(game, ": ")

      rgb_counts = get_counts(game_text)

      if RGB.draws_are_possible?(rgb_counts, max_required) do
        game_number
        |> Helpers.unsafe_string_to_integer()
        |> Kernel.+(acc)
      else
        acc
      end
    end)
  end

  @doc """
  Examples:

      iex> Day2.part_2()
      56_580

  """
  @spec part_2() :: integer
  def part_2() do
    input = get_input()

    Enum.reduce(input, 0, fn game, acc ->
      [_game_number, game_text] = String.split(game, ": ")

      %RGB{red: red, green: green, blue: blue} = get_counts(game_text)
      power = red * green * blue

      acc + power
    end)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_counts(String.t()) :: RGB.t()
  defp get_counts(game_string) do
    game_string
    |> String.replace(" ", "")
    |> String.replace(";", ",")
    |> String.split(",")
    |> Enum.reduce(RGB.new(), fn new_draw, acc ->
      {count, color} = Integer.parse(new_draw)
      RGB.merge(acc, color, count)
    end)
  end

  @spec get_input() :: list(String.t())
  defp get_input() do
    2
    |> Helpers.read_file("Y23")
    |> String.split("\n", trim: true)
  end
end
