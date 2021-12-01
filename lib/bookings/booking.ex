defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(%NaiveDateTime{} = complete_date, local_origin, local_destination, user_id) do
    uuid = UUID.uuid4()

    {:ok,
     %__MODULE__{
       complete_date: complete_date,
       id: uuid,
       local_destination: local_destination,
       local_origin: local_origin,
       user_id: user_id
     }}
  end

  def build(_complete_date, _local_origin, _local_destination, _user_id) do
    {:error, "Complete date shoul a Naive Datetime"}
  end
end
