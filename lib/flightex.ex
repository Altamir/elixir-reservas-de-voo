defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookinAgent
  alias Flightex.Users.Agent, as: UserAgent

  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking

  def start_agents do
    UserAgent.start_link(%{})
    BookinAgent.start_link(%{})
  end

  def create_or_update_booking(params) do
    CreateOrUpdateBooking.call(params)
  end
end
