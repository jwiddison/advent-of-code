defmodule AdventOfCode.Y22.Day7 do
  @moduledoc """
  https://adventofcode.com/2022/day/7
  """
  alias AdventOfCode.Helpers

  @type command :: String.t()
  @type path :: list
  @type sizes :: map

  @doc """
  Examples:

      iex> Day7.part_1()
      1_348_005

  """
  @spec part_1() :: integer
  def part_1() do
    commands = get_commands()

    commands
    |> commands_to_file_sizes()
    |> Enum.filter(fn {_path, size} -> size <= 100_000 end)
    |> Enum.reduce(0, fn {_path, size}, total_size -> total_size + size end)
  end

  @doc """
  Examples:

      iex> Day7.part_2()
      12_785_886

  """
  @spec part_2() :: integer
  def part_2() do
    commands = get_commands()

    commands
    |> commands_to_file_sizes()
    |> Enum.filter(fn {_path, size} -> size > 8_381_165 end)
    |> Enum.min_by(fn {_path, total_size} -> total_size end)
    |> elem(1)
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_commands() :: list(command)
  defp get_commands() do
    7
    |> Helpers.read_file("Y22")
    |> String.split("\n", trim: true)
  end

  @spec commands_to_file_sizes(list(command)) :: sizes
  defp commands_to_file_sizes(commands) do
    {_final_path, final_sizes} = Enum.reduce(commands, {["/"], %{}}, &handle_command/2)
    final_sizes
  end

  @spec handle_command(command, {path, sizes}) :: {path, sizes}
  defp handle_command("$ cd /", {_path, sizes}), do: {["/"], sizes}
  defp handle_command("$ cd ..", {path, sizes}), do: {Enum.drop(path, -1), sizes}
  defp handle_command("$ cd " <> new_folder, {path, sizes}), do: {path ++ [new_folder], sizes}
  defp handle_command("$ ls", {path, sizes}), do: {path, sizes}
  defp handle_command("dir " <> _dir_name, {path, sizes}), do: {path, sizes}

  defp handle_command(file_with_size, {path, sizes}) do
    [file_size | _rest] = String.split(file_with_size, " ")
    {int_file_size, _rem} = Integer.parse(file_size)

    {path, update_total_sizes(path, sizes, int_file_size)}
  end

  @spec update_total_sizes(path, sizes, file_size :: integer) :: sizes
  defp update_total_sizes([], sizes, _int_file_size), do: sizes

  defp update_total_sizes(path, sizes, int_file_size) do
    path_to_size = Enum.join(path, "/")
    new_sizes = Map.update(sizes, path_to_size, int_file_size, fn current_size -> current_size + int_file_size end)

    path
    |> Enum.drop(-1)
    |> update_total_sizes(new_sizes, int_file_size)
  end
end
