defmodule HotwirePhoenixDemoChatWeb.MessageView do
  use HotwirePhoenixDemoChatWeb, :view

  def short_datetime(datetime) do
    Calendar.strftime(datetime, "%d %b %H:%M")
  end
end
