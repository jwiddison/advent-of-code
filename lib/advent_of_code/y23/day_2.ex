defmodule AdventOfCode.Y23.Day2 do
  @moduledoc """
  https://adventofcode.com/2023/day/2
  """
  alias AdventOfCode.Inputs

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

    actual = %RGB{red: 12, green: 13, blue: 14}

    Enum.reduce(input, 0, fn game, acc ->
      ["Game " <> game_number, game_text] = String.split(game, ": ")

      max_draws =
        game_text
        |> String.replace(" ", "")
        |> String.replace(";", ",")
        |> String.split(",")
        |> get_max_draws()

      if RGB.draws_are_possible?(max_draws, actual) do
        game_number
        |> Integer.parse()
        |> elem(0)
        |> Kernel.+(acc)
      else
        acc
      end
    end)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_input() :: list(String.t())
  defp get_input() do
    2
    |> Inputs.read_file("Y23")
    |> String.split("\n", trim: true)
  end

  @spec get_max_draws(list(String.t())) :: RGB.t()
  defp get_max_draws(list_of_draws) do
    Enum.reduce(list_of_draws, RGB.new(), fn new_draw, acc ->
      {count, color} = Integer.parse(new_draw)
      RGB.merge(acc, color, count)
    end)
  end
end
