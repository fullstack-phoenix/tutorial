defmodule TutorialWeb.Live.InitAssigns do
  import Phoenix.LiveView

  alias Tutorial.Customers

  @cache_name :data_cache
  @default_ttl 1_000 * 60 * 10

  def on_mount(:load_customers, params, _session, socket) do
    hash = :erlang.phash2(params)
    customers = with_cache("customers-cache-#{hash}", (fn -> Customers.list_customers(params) end))

    {
      :cont,
      socket
      |> assign(:customers, customers)
    }
  end

  def with_cache(key, fun) do
    case Cachex.get(@cache_name, key) do
      {:ok, nil} ->
        result = fun.()
        Cachex.put(@cache_name, key, result, ttl: @default_ttl)
        result
      {:ok, result} ->
        result
    end
  end

  def expire_cache(), do: Cachex.clear(@cache_name)
  def expire_cache(key), do: Cachex.del(@cache_name, key)
end
