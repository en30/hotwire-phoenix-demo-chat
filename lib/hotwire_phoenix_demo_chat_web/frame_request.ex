defmodule HotwirePhoenixDemoChatWeb.FrameRequest do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "turbo-frame") do
      [] -> conn
      _ -> put_layout(conn, false)
    end
  end
end
