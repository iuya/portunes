defmodule PortunesCore.Pushers.Stub do
  @moduledoc """
  A simple pusher stub. Since all the fuctions are commands, we just return :ok
  """

  @behaviour PortunesCore.Pusher

  @impl true
  def notify_update(_repo_name, _version), do: :ok

  @impl true
  def push_snapshot(_repo_name, _version), do: :ok
end
