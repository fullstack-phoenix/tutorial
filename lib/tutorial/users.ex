defmodule Tutorial.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Tutorial.Repo
  alias Tutorial.Users.User

  def list_users_from_last_day do
    from(
      u in User,
      where: u.inserted_at > ago(1, "day")
    )
    |> Repo.all()
  end
end
