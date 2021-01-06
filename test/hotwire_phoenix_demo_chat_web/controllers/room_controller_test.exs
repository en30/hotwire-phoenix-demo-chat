defmodule HotwirePhoenixDemoChatWeb.RoomControllerTest do
  use HotwirePhoenixDemoChatWeb.ConnCase

  alias HotwirePhoenixDemoChat.Chat

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:room) do
    {:ok, room} = Chat.create_room(@create_attrs)
    room
  end

  describe "index" do
    test "lists all rooms", %{conn: conn} do
      conn = get(conn, Routes.room_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rooms"
    end
  end

  describe "new room" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.room_path(conn, :new))
      assert html_response(conn, 200) =~ "New Room"
    end
  end

  describe "create room" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.room_path(conn, :create), room: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.room_path(conn, :show, id)

      conn = get(conn, Routes.room_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Room"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.room_path(conn, :create), room: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Room"
    end
  end

  describe "edit room" do
    setup [:create_room]

    test "renders form for editing chosen room", %{conn: conn, room: room} do
      conn = get(conn, Routes.room_path(conn, :edit, room))
      assert html_response(conn, 200) =~ "Edit Room"
    end
  end

  describe "update room" do
    setup [:create_room]

    test "redirects when data is valid", %{conn: conn, room: room} do
      conn = put(conn, Routes.room_path(conn, :update, room), room: @update_attrs)
      assert redirected_to(conn) == Routes.room_path(conn, :show, room)

      conn = get(conn, Routes.room_path(conn, :show, room))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, room: room} do
      conn = put(conn, Routes.room_path(conn, :update, room), room: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Room"
    end
  end

  describe "delete room" do
    setup [:create_room]

    test "deletes chosen room", %{conn: conn, room: room} do
      conn = delete(conn, Routes.room_path(conn, :delete, room))
      assert redirected_to(conn) == Routes.room_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.room_path(conn, :show, room))
      end
    end
  end

  defp create_room(_) do
    room = fixture(:room)
    %{room: room}
  end
end
