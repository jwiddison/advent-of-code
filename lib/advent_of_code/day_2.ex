defmodule AdventOfCode.Day2 do
  @moduledoc """
  Advent of Code 2022, Day 2: Friday December 2
  https://adventofcode.com/2022/day/2
  """
  alias AdventOfCode.Inputs

  @opponent_rock "A"
  @opponent_paper "B"
  @opponent_scissors "C"

  @player_rock "X"
  @player_paper "Y"
  @player_scissors "Z"

  @need_to_lose "X"
  @need_to_draw "Y"
  @need_to_win "Z"

  @points %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @outcomes %{
    lose: 0,
    draw: 3,
    win: 6
  }

  @doc """
  Examples:

      iex> Day2.get_total_score_part_1()
      14_264

  """
  @spec get_total_score_part_1() :: integer
  def get_total_score_part_1() do
    list_of_matches = get_list_of_matches()

    list_of_matches
    |> Enum.map(&part_1/1)
    |> Enum.sum()
  end

  @doc """
  Examples:

      iex> Day2.get_total_score_part_2()
      12_382

  """
  @spec get_total_score_part_2() :: integer
  def get_total_score_part_2() do
    list_of_matches = get_list_of_matches()

    list_of_matches
    |> Enum.map(&part_2/1)
    |> Enum.sum()
  end

  ################################################################################
  # Private
  ################################################################################

  # When the 2nd letter is the player
  @spec part_1(list(String.t())) :: integer
  defp part_1([@opponent_rock, @player_paper]), do: Map.get(@outcomes, :win) + Map.get(@points, :paper)
  defp part_1([@opponent_rock, @player_rock]), do: Map.get(@outcomes, :draw) + Map.get(@points, :rock)
  defp part_1([@opponent_rock, @player_scissors]), do: Map.get(@outcomes, :lose) + Map.get(@points, :scissors)

  defp part_1([@opponent_paper, @player_paper]), do: Map.get(@outcomes, :draw) + Map.get(@points, :paper)
  defp part_1([@opponent_paper, @player_rock]), do: Map.get(@outcomes, :lose) + Map.get(@points, :rock)
  defp part_1([@opponent_paper, @player_scissors]), do: Map.get(@outcomes, :win) + Map.get(@points, :scissors)

  defp part_1([@opponent_scissors, @player_paper]), do: Map.get(@outcomes, :lose) + Map.get(@points, :paper)
  defp part_1([@opponent_scissors, @player_rock]), do: Map.get(@outcomes, :win) + Map.get(@points, :rock)
  defp part_1([@opponent_scissors, @player_scissors]), do: Map.get(@outcomes, :draw) + Map.get(@points, :scissors)

  # When the second letter is the outcome
  @spec part_2(list(String.t())) :: integer
  defp part_2([@opponent_rock, @need_to_draw]), do: Map.get(@outcomes, :draw) + Map.get(@points, :rock)
  defp part_2([@opponent_rock, @need_to_lose]), do: Map.get(@outcomes, :lose) + Map.get(@points, :scissors)
  defp part_2([@opponent_rock, @need_to_win]), do: Map.get(@outcomes, :win) + Map.get(@points, :paper)

  defp part_2([@opponent_paper, @need_to_draw]), do: Map.get(@outcomes, :draw) + Map.get(@points, :paper)
  defp part_2([@opponent_paper, @need_to_lose]), do: Map.get(@outcomes, :lose) + Map.get(@points, :rock)
  defp part_2([@opponent_paper, @need_to_win]), do: Map.get(@outcomes, :win) + Map.get(@points, :scissors)

  defp part_2([@opponent_scissors, @need_to_draw]), do: Map.get(@outcomes, :draw) + Map.get(@points, :scissors)
  defp part_2([@opponent_scissors, @need_to_lose]), do: Map.get(@outcomes, :lose) + Map.get(@points, :paper)
  defp part_2([@opponent_scissors, @need_to_win]), do: Map.get(@outcomes, :win) + Map.get(@points, :rock)

  @spec get_list_of_matches() :: list(String.t())
  defp get_list_of_matches() do
    2
    |> Inputs.read_file()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
  end
end
