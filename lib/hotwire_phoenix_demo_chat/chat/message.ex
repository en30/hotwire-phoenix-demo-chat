defmodule HotwirePhoenixDemoChat.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string

    belongs_to :room, HotwirePhoenixDemoChat.Chat.Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :room_id])
    |> validate_required([:content])
    |> assoc_constraint(:room)
  end
end
