defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.{Agent, CreateOrUpdate}

  describe "call/1" do
    setup do
      Agent.start_link(%{})

      :ok
    end

    test "when all params are valid, returns a valid tuple" do
      params = %{
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e"
      }

      {:ok, uuid} = CreateOrUpdate.call(params)

      {:ok, response} = Agent.get(uuid)

      expected_response = %Flightex.Bookings.Booking{
        id: response.id,
        complete_date: ~N[2001-05-07 03:05:00],
        local_destination: "Bananeiras",
        local_origin: "Brasilia",
        user_id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e"
      }

      assert response == expected_response
    end

    test "when a error on create booking, return error" do
      params = %{
        complete_date: ~U[2021-11-11 00:00:01Z],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e"
      }

      {:error, msg} = CreateOrUpdate.call(params)
      assert {:error, "Complete date should a Naive Datetime"} == {:error, msg}
    end
  end
end
