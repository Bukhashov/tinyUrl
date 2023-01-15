defmodule TinyUrlTest.Router do
  use ExUnit.Case
  # doctest TinyUrl

  use Plug.Test

  @opts TinyUrl.Router.init([])

  test "test endpoint ok" do
    conn = conn(:get, "/")
    conn = TinyUrl.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK"
  end
end
