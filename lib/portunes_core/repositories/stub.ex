defmodule PortunesCore.Repositories.Stub do
  @moduledoc """
  Repository that communicates with any Git-based repository
  """

  @behaviour PortunesCore.Repository

  alias PortunesCore.Snapshot

  @impl true
  def get_last_version(_repo_name, _opts) do
    {:ok, "LAST_VERSION"}
  end

  @impl true
  def get_last_snapshot(repo_name, _opts) do
    {:ok,
     %Snapshot{
       metadata: %{},
       properties: %{},
       version: "LAST_VERSION",
       repo_name: repo_name
     }}
  end

  @impl true
  def get_snapshot(repo_name, version, _opts) do
    {:ok,
     %Snapshot{
       metadata: %{},
       properties: %{},
       version: version,
       repo_name: repo_name
     }}
  end
end
