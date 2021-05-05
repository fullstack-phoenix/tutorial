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
      where: fragment("? > NOW() - INTERVAL '1 DAY'", u.inserted_at)
    )
    |> Repo.all()
  end
end
