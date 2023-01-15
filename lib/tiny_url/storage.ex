defmodule TinyUrl.Storage do
  def create(link) do
    q = "INSERT INTO links (link, counter) VALUES($1, $2) RETURNING id"
    {status, res} = Postgrex.query(:postgres, q,[link, 0])
    if status === :ok do
      res.rows |> List.first |> List.first
    end
  end

  def save_short(id, short_link) do
    q = "UPDATE links SET short=$2 WHERE id=$1"
    {status, _res} = Postgrex.query(:postgres, q,[id, short_link])
    if status == :ok do
      status
    end
  end


  def get_link(short) do
    q = "SELECT id, link, counter FROM links WHERE short=$1"
    {status, res} = Postgrex.query(:postgres, q, [short])

    if status == :ok do
      data = res.rows |> List.first
      if data == :nil do
        :nil
      else
        data
      end
    else
      :nil
    end
  end

  def update_counter(id, counter) do
    q = "UPDATE links SET counter=$2 WHERE id=$1"
    {status, _res} = Postgrex.query(:postgres, q, [id, counter])
    status
  end
end
