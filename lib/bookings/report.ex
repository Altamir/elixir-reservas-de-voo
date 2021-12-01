defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.Booking

  def generate(filename \\ "report.csv") do
    bookings_list = build_bookings_list()

    File.write(filename, bookings_list)
  end

  defp build_bookings_list do
    BookingsAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         complete_date: complete_date,
         local_destination: local_destination,
         local_origin: local_origin,
         user_id: user_id
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
