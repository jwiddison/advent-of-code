defmodule AdventOfCode.Day7 do
  @moduledoc """
  Advent of Code 2022, Day 7: Wednesday December 7
  https://adventofcode.com/2022/day/7
  """
  alias AdventOfCode.Inputs

  @type command :: String.t()
  @type directory :: map
  @type path :: String.t()

  @doc """
  Examples:

      iex> Day7.part_1()
      1_348_005

  """
  @spec part_1() :: integer
  def part_1() do
    commands = get_commands()

    commands
    |> commands_to_file_tree()
    |> Enum.filter(fn {_path, size} -> size <= 100_000 end)
    |> Enum.reduce(0, fn {_path, size}, total_size -> total_size + size end)
  end

  @doc """
  Examples:

      iex> Day7.part_2()
      0

  """
  @spec part_2() :: integer
  def part_2() do
    _commands = get_commands()
    0
  end

  ################################################################################
  # Private
  ################################################################################

  @spec get_commands() :: list(command)
  defp get_commands() do
    7
    |> Inputs.read_file()
    |> String.split("\n", trim: true)
  end

  @spec commands_to_file_tree(list(command)) :: directory
  defp commands_to_file_tree(commands) do
    start_path = ["/"]
    start_dir = %{"/" => %{}}
    start_sizes = %{}

    commands
    |> Enum.reduce({start_path, start_dir, start_sizes, 1}, &handle_command/2)
    |> elem(2)
  end

  @spec handle_command(command, {path, directory, map, integer}) :: {path, directory, map, integer}
  defp handle_command("$ cd /", {_path, directory, sizes, x}), do: {["/"], directory, sizes, x + 1}

  defp handle_command("$ cd ..", {path, directory, sizes, x}), do: {Enum.drop(path, -1), directory, sizes, x + 1}

  defp handle_command("$ cd " <> new_folder, {path, directory, sizes, x}) do
    new_path = path ++ [new_folder]

    new_dir =
      if get_in(directory, new_path) do
        directory
      else
        put_in(directory, new_path, %{})
      end

    {new_path, new_dir, sizes, x + 1}
  end

  # do nothing
  defp handle_command("$ ls", {path, directory, sizes, x}), do: {path, directory, sizes, x + 1}

  # do nothing
  defp handle_command("dir " <> _dir_name, {path, directory, sizes, x}), do: {path, directory, sizes, x + 1}

  defp handle_command(file_with_size, {path, directory, sizes, x}) do
    [file_size, file_name] = String.split(file_with_size, " ", trim: true)
    {int_file_size, _rem} = Integer.parse(file_size)
    path_to_file = path ++ [file_name]

    new_dir = put_in(directory, path_to_file, int_file_size)

    new_sizes = update_total_sizes(path, sizes, int_file_size, x)

    {path, new_dir, new_sizes, x + 1}
  end

  defp update_total_sizes(["/"], sizes, int_file_size, _x) do
    Map.update(sizes, "/", int_file_size, fn current_size -> current_size + int_file_size end)
  end

  defp update_total_sizes(path, sizes, int_file_size, x) do
    path_to_size = Enum.join(path, "/")
    new_sizes = Map.update(sizes, path_to_size, int_file_size, fn current_size -> current_size + int_file_size end)

    path
    |> Enum.drop(-1)
    |> update_total_sizes(new_sizes, int_file_size, x)
  end
end
