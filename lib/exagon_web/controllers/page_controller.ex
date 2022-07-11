defmodule ExagonWeb.PageController do
  use ExagonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
