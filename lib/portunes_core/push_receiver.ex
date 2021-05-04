defmodule PortunesCore.PushReceiver do
  @moduledoc """
  Handles push notifications from external repositories, examples are: github push notifications,
  or even other portunes (since they could be daily-chained, although it is arguably useless)
  """

  alias PortunesCore.PushReceivers

  @type repo_name :: String.t()
  @type opts :: map

  @callback handle_notification(repo_name, map, opts) :: :ok | {:ok, term}

  ## Dispatcher
  @adapter Application.compile_env(:portunes_core, [:push_receiver, :adapter], PushReceivers.Stub)

  @spec handle_notification(repo_name, map, opts) :: :ok | {:ok, term}
  defdelegate handle_notification(repo_name, notification, opts), to: @adapter
end
