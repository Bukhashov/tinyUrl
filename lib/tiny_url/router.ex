defmodule TinyUrl.Router do
  alias TinyUrl.Storage
  use Plug.Router

  @template_dir "lib/tiny_url/templates"

  plug(Plug.Logger)
  plug :match
  plug CORSPlug
  plug(Plug.Parsers,
        parsers: [:json],
        pass: ["application/json"],
        json_decoder: Jason
      )
  plug(:dispatch)

  post "/" do
    link_id = conn.body_params["link"] |> Storage.create
    short = Base58.encode(link_id)
    status = Storage.save_short(link_id, short)

    if status == :ok do

      send_resp(conn, 200, Jason.encode!(%{link: "http://localhost:8000/#{short}"}))
    end
  end

  get "/:short_uri" do
    data = Storage.get_link(short_uri)

    if data == :nil do
      send_resp(conn, 400, "#{short_uri}")
    else
      [id, link, counter] = data

      status = Storage.update_counter(id, counter+1)
      if status == :ok do
        render(conn, "short.html", [link: link])
      end

      # send_resp(conn, 200, "#{id} #{link} #{counter}")
    end
  end

  match _ do
    send_resp(conn, 400, "Not Found")
  end

  defp render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)
    send_resp(conn, (status || 200), body)
  end
end
