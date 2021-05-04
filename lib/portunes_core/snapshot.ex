defmodule PortunesCore.Snapshot do
  @moduledoc """
  Contains an snapshot of configuration from a remote configration repository and all of its
  associated metadata.

  The meaning of this metadata is up to the `Portunes.Repository` adapter used.
  """

  use TypedStruct

  typedstruct do
    @typedoc "A remote repository snapshot"

    field(:repo_name, String.t(), enforce: true)
    field(:version, String.t(), enforce: true, default: "")
    field(:properties, map(), enforce: true)
    field(:metadata, map, enforce: true, default: %{})
  end
end
