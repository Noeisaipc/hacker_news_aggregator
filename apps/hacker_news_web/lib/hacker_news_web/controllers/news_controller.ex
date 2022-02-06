defmodule HackerNewsWeb.NewsController do
  use HackerNewsWeb, :controller

  def index(conn, %{"page" => page}) do
    pagination = HackerNewsCore.generate_pagination(page)

    conn
    |> put_status(200)
    |> render("index.json", pagination: pagination)
  end

  def index(conn, _params) do
    pagination = HackerNewsCore.generate_pagination(nil)

    conn
    |> put_status(200)
    |> render("index.json", pagination: pagination)
  end

  def show(conn, %{"id" => id}) do
    case HackerNewsCore.find_news(id) do
      nil ->
        conn
        |> put_status(404)
        |> render("no_found.json", %{})

      news ->
        conn
        |> put_status(200)
        |> render("news.json", news: news)
    end
  end
end
