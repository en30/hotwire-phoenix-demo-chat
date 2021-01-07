defmodule HotwirePhoenixDemoChatWeb.StreamRequest do
  @turbo_stream_mime_type "text/html; turbo-stream"
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  @doc"""
  Force format turbo_stream because phoenix (Plug.Conn.Utils.media_type/1)
  judge `text/html; turbo-stream` as html even if mime's config exists.
  This will be unecessary when beta 3 is published.
  See https://github.com/hotwired/turbo/issues/24
  """
  def call(conn, _opts) do
    conn
    |> get_req_header("accept")
    |> Enum.any?(fn mime_type -> String.contains?(mime_type, @turbo_stream_mime_type) end)
    |> case do
      true ->
        conn
        |> put_format("turbo_stream")

      false -> conn
    end
  end
end
