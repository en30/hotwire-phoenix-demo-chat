defmodule HotwirePhoenixDemoChatWeb.ChannelName do
  @salt "hot wire channel"
  @max_age 86400

  def sign(context, channel) do
    Phoenix.Token.sign(context, @salt, channel)
  end

  def verify(context, signed) do
    Phoenix.Token.verify(
      context,
      @salt,
      signed,
      max_age: @max_age
    )
  end
end
