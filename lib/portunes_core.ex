defmodule PortunesCore do
  @moduledoc """
  This module acts as the public interface for accessing PortunesCore functionality, which
  includes:

  - Getting the current config properties from storage
  - Fetching the properties from the remote repository and updating the store
    - At client's request
    - When the remote repository notifies changes or pushes new config direclty
    - After a predetermined heartbeat
  - Pushing updates to connected clients

  In most cases this module will just call an underlaying module which does all the work
  """

  alias PortunesCore.Store
  alias PortunesCore.PushReceiver
  alias PortunesCore.Pusher
  alias PortunesCore.Snapshot
  alias PortunesCore.State

  @type repo_name :: String.t()
  @type property_name :: String.t()
  @type opts :: map

  @type ok_property :: {:ok, term}
  @type ok_snapshot :: {:ok, Snapshot.t()}
  @type error_tuple :: {:error, term}

  #################################### Public Interface ##########################################

  @doc """
  Returns the property from the requested cofiguration repository
  """
  @spec get_property(property_name, repo_name, opts) :: ok_property | error_tuple
  defdelegate get_property(property_name, repo_name, opts \\ %{}), to: Store

  @doc """
  Returns the current snapshot for the requested cofiguration repository
  """
  @spec get_snapshot(repo_name, opts) :: ok_snapshot | error_tuple
  defdelegate get_snapshot(repo_name, opts \\ %{}), to: Store

  @doc """
  Updates the given repository with new info
  """
  @spec force_snapshot_update(repo_name, opts) :: :ok | error_tuple
  defdelegate force_snapshot_update(repo_name, opts \\ %{}), to: State

  @doc """
  Updates the given repository with new info
  """
  @spec handle_notification(repo_name, term, opts) :: :ok | error_tuple
  defdelegate handle_notification(repo_name, notification, opts \\ %{}), to: PushReceiver

  @spec notify_update(repo_name, opts) :: :ok | error_tuple
  defdelegate notify_update(repo_name, opt \\ %{}), to: Pusher

  @spec push_snapshot(repo_name, opts) :: :ok | error_tuple
  defdelegate push_snapshot(repo_name, opt \\ %{}), to: Pusher

  ################################################################################################
end
