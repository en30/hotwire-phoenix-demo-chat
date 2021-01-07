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

  def turbo_stream_tag(:remove, target) do
    content_tag("turbo-stream", "", action: :remove, target: target)
  end

  @template_actions [:replace, :update, :append, :prepend]

  def turbo_stream_tag(action, target, do: block) when action in @template_actions do
    turbo_stream_tag(action, target, block)
  end

  def turbo_stream_tag(action, target, template) when action in @template_actions do
    content_tag("turbo-stream", action: action, target: target) do
      content_tag("template", template)
    end
  end
end
