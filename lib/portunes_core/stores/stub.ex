defmodule PortunesCore.Stores.Stub do
  @moduledoc """
  Simple dev stub for testing contracts and
  """

  @behaviour PortunesCore.Store

  alias PortunesCore.Snapshot

  @impl true
  def get_property(property_name, _repo_name, _opts) do
    case property_name do
      "map" -> {:ok, %{}}
      binary when binary in ["string", "binary"] -> {:ok, "PROPERTY_VALUE"}
      "list" -> {:ok, []}
    end
  end

  @impl true
  def get_snapshot(repo_name, _opts) do
    {:ok,
     %Snapshot{
       repo_name: repo_name,
       version: "LAST_VERSION",
       properties: %{},
       metadata: %{}
     }}
  end

  @impl true
  def put_snapshot(_repo_name, _configuration, _opts) do
    :ok
  end
end
