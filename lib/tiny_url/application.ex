defmodule TinyUrl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @impl true
  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: TinyUrl.Router,
        options: [port: Application.get_env(:tiny_url, :port)]
      },
      {
        Postgrex,
        [
          name: :postgres,
          hostname: Application.get_env(:tiny_url, :hostname),
          database: Application.get_env(:tiny_url, :database),
          username: Application.get_env(:tiny_url, :username),
          password: Application.get_env(:tiny_url, :password),
        ]
      },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TinyUrl.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
