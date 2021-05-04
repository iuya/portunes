defmodule PortunesCore.Repository do
  @moduledoc """
  Defines the API for accessing configuration repositories, for example a Git repo, a http site or
  any other place where we might persist the configuration.
  """

  alias PortunesCore.Snapshot
  alias PortunesCore.Repositories

  @type repo_name :: String.t()
  @type version :: String.t()
  @type opts :: map

  @type ok_snapshot :: {:ok, Snapshot.t()}
  @type error :: {:error, term}

  @callback get_last_version(repo_name, opts) :: {:ok, String.t()} | error
  @callback get_last_snapshot(repo_name, opts) :: ok_snapshot | error
  @callback get_snapshot(repo_name, version, opts) :: ok_snapshot | error | :noop

  ## Dispatcher
  @adapter Application.compile_env(:portunes_core, [:repository, :adapter], Repositories.Stub)

  @spec get_last_version(repo_name, opts) :: {:ok, String.t()} | error
  defdelegate get_last_version(repo_name, opts \\ %{}), to: @adapter

  @spec get_last_snapshot(repo_name, opts) :: ok_snapshot | error
  defdelegate get_last_snapshot(repo_name, opts \\ %{}), to: @adapter

  @spec get_snapshot(repo_name, version, opts) :: ok_snapshot | error | :noop
  defdelegate get_snapshot(repo_name, version, opts \\ %{}), to: @adapter
end
