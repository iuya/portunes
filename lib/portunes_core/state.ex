defmodule PortunesCore.State do
  @moduledoc """
  This module hadles the state of portunes core, making sure everything stays consistent and
  coordinating updates to the store.
  """

  alias PortunesCore.Store
  alias PortunesCore.Repository
  alias PortunesCore.Pusher

  @type repo_name :: String.t()
  @type opts :: map

  ## TODO PORTIFY THIS

  @spec(force_snapshot_update(repo_name, opts) :: :ok, {:error, term})
  def force_snapshot_update(repo_name, _opts \\ %{}) do
    with {:ok, %{version: last_version} = snapshot} <- Repository.get_last_snapshot(repo_name),
         {:ok, %{version: current_version}} <- Store.get_snapshot(repo_name),
         false <- last_version == current_version,
         :ok <- Store.put_snapshot(repo_name, snapshot) do
      Pusher.notify_update(repo_name, last_version)
    else
      true -> :ok
    end

    # Todo handle errors
  end
end
