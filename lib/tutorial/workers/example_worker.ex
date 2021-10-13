defmodule Tutorial.Workers.ExampleWorker do
  use Oban.Worker

  @impl Oban.Worker
  def perform(_job) do
    # Perform some work and then return :ok

    :ok
  end
end