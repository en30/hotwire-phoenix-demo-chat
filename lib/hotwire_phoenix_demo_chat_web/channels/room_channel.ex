defmodule HotwirePhoenixDemoChatWeb.RoomChannel do
  use HotwirePhoenixDemoChatWeb, :channel
  require Logger

  alias HotwirePhoenixDemoChatWeb.{Endpoint, MessageView, ChannelName}

  @impl Phoenix.Channel
  def join(channel = "room:" <> _room_id, %{"signed_channel_name" => signed_channel_name}, socket) do
    case ChannelName.verify(socket, signed_channel_name) do
      {:ok, channel} -> {:ok, socket}
      _ ->
        Logger.error("#{__MODULE__} invalid token for channel '#{channel}'")
        {:error, "unauthorized"}
    end
  end

  def join(channel = "room:" <> _room_id, _, socket) do
      Logger.error("#{__MODULE__} token is not provided for channel '#{channel}'")
      {:error, "unauthorized"}
  end

  def notify_message_creation(message) do
    stream =
      Phoenix.View.render_to_string(
        MessageView,
        "create.turbo_stream",
        message: message
      )

    Endpoint.broadcast!("room:#{message.room_id}", "new_message", %{
      stream: stream
    })
  end

  def notify_message_update(message) do
    stream =
      Phoenix.View.render_to_string(
        MessageView,
        "update.turbo_stream",
        message: message
      )

    Endpoint.broadcast!("room:#{message.room_id}", "new_message", %{
      stream: stream
    })
  end

  def notify_message_deletion(message) do
    stream =
      Phoenix.View.render_to_string(
        MessageView,
        "delete.turbo_stream",
        message: message
      )

    Endpoint.broadcast!("room:#{message.room_id}", "new_message", %{
      stream: stream
    })
  end
end
