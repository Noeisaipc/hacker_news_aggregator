defmodule HackerNewsWeb.NewsView do
  use HackerNewsWeb, :view

  @spec render(String.t(), map()) :: map()
  def render("index.json", %{pagination: pagination}) do
    %{
      news: pagination.entries,
      page_number: pagination.page_number,
      page_size: pagination.page_size,
      total_pages: pagination.total_pages
    }
  end

  @spec render(String.t(), map()) :: map()
  def render("news.json", %{news: news}) do
    news
  end

  @spec render(String.t(), map()) :: map()
  def render("no_found.json", %{}) do
    %{}
  end
end
