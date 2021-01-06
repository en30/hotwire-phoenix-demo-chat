defmodule HotwirePhoenixDemoChatWeb.TurboView do
  use HotwirePhoenixDemoChatWeb, :view

  def turbo_frame_tag(id, do: block) do
    content_tag("turbo-frame", block, id: id)
  end

  def turbo_frame_tag(id, attrs) when is_list(attrs) do
    turbo_frame_tag(id, "", attrs)
  end

  def turbo_frame_tag(id, attrs, do: block) when is_list(attrs) do
    turbo_frame_tag(id, block, attrs)
  end

  def turbo_frame_tag(id, content, attrs) when is_list(attrs) do
    content_tag("turbo-frame", content, [{:id, id} | attrs])
  end
end
