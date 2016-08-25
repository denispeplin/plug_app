defmodule PlugApp do
  use Application
  import Plug.Conn

  def start(_type, _args) do
    children = [Plug.Adapters.Cowboy.child_spec(:http, PlugApp, [])]

    opts = [strategy: :one_for_one, name: PlugApp.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello world")
  end
end
