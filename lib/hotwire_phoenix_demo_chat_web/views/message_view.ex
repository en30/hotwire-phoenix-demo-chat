defmodule HotwirePhoenixDemoChatWeb.MessageView do
  use HotwirePhoenixDemoChatWeb, :view

  alias HotwirePhoenixDemoChatWeb.TurboView

  def short_datetime(datetime) do
    Calendar.strftime(datetime, "%d %b %H:%M")
  end

  def render("create.turbo_stream", %{message: message})  do
    TurboView.turbo_stream_tag(:append, "messages") do
      render_one(message, __MODULE__, "_message.html")
    end
  end

  def render("update.turbo_stream", %{message: message})  do
    TurboView.turbo_stream_tag(:replace, dom_id(message)) do
      render_one(message, __MODULE__, "_message.html")
    end
  end

  def render("delete.turbo_stream", %{message: message})  do
    TurboView.turbo_stream_tag(:remove, dom_id(message))
  end

  defp dom_id(message), do: "message_#{message.id}"
end
