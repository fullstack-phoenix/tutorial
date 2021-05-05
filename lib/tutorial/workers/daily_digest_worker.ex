defmodule Tutorial.Workers.DailyDigestWorker do
  use Oban.Worker

  alias Tutorial.{Users, Emails, Mailer}

  @impl Oban.Worker
  def perform(_job) do
    Users.list_users_from_last_day()
    |> Emails.digest_email()
    |> Mailer.deliver_now()

    :ok
  end
end
