defmodule PortunesCore.PushReceivers.Stub do
  @moduledoc """
  A simple pusher stub. Since all the fuctions are commands, we just return :ok
  """

  @behaviour PortunesCore.PushReceiver

  @impl true
  def handle_notification(_repo_name, _notification, _version), do: :ok
end
