defmodule PortunesCore.Pusher do
  @moduledoc """
  Describes any module whose purpose is sending notifications about updates in any given repo state
  """

  alias PortunesCore.Pushers

  @type repo_name :: String.t()
  @type version :: String.t()

  @callback notify_update(repo_name, version) :: :ok | {:error, term}
  @callback push_snapshot(repo_name, version) :: :ok | {:error, term}

  ## Dispatcher
  @adapter Application.compile_env(:portunes_core, [:pusher, :adapter], Pushers.Stub)

  @callback notify_update(repo_name, version) :: :ok | {:error, term}
  defdelegate notify_update(repo_name, version), to: @adapter

  @callback push_snapshot(repo_name, version) :: :ok | {:error, term}
  defdelegate push_snapshot(repo_name, version), to: @adapter
end
