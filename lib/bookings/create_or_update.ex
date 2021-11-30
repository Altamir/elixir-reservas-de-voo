defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: OrderAgent
  alias Flightex.Bookings.Booking

  def call(%{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }) do
    Booking.build(complete_date, local_origin, local_destination, user_id)
    |> handler()
  end

  defp handler({:ok, booking}) do
    OrderAgent.save(booking)
  end

  defp handler({:error, _reason} = error), do: error
end
