defmodule HotwirePhoenixDemoChat.Repo do
  use Ecto.Repo,
    otp_app: :hotwire_phoenix_demo_chat,
    adapter: Ecto.Adapters.Postgres
end
