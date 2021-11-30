defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    User.build(name, email, cpf)
    |> save_user
  end

  def save_user({:ok, user}) do
    UserAgent.save(user)
    {:ok, "User created sucessfully"}
  end

  def save_user({:error, _reason} = error), do: error
end