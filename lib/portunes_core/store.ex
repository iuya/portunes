defmodule PortunesCore.Store do
  @moduledoc """
  This module defines the behaviour of a data store used to chache the properties from any \
  snapshot source
  """

  alias PortunesCore
  alias PortunesCore.Stores
  alias PortunesCore.Snapshot

  @type property_name :: String.t()
  @type repo_name :: String.t()
  @type opts :: map

  @type error_tuple :: {:error, term}

  @callback get_property(property_name, repo_name, opts) :: {:ok, term} | error_tuple()
  @callback get_snapshot(repo_name, opts) :: {:ok, Snapshot.t()} | error_tuple
  @callback put_snapshot(repo_name, Snapshot.t(), opts) :: :ok | error_tuple

  @adapter Application.compile_env(:portunes_core, [:store, :adapter], Stores.Stub)

  @spec get_property(property_name, repo_name, opts) :: {:ok, term} | error_tuple()
  defdelegate get_property(property_name, repo_name, opts \\ %{}), to: @adapter

  @spec get_snapshot(String.t(), opts) :: {:ok, Snapshot.t()} | error_tuple
  defdelegate get_snapshot(repo_name, opts \\ %{}), to: @adapter

  @spec put_snapshot(String.t(), Snapshot.t(), opts) :: :ok | error_tuple
  defdelegate put_snapshot(repo_name, new_snapshot, opts \\ %{}), to: @adapter
end
