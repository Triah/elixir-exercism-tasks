defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime, 0} = DateTime.from_iso8601(string) 
    DateTime.to_naive(datetime)
  end

  def before_noon?(datetime), do: datetime.hour < 12

  def return_date(checkout_datetime) do
    as_date = NaiveDateTime.to_date(checkout_datetime)
    if before_noon?(checkout_datetime), do: Date.add(as_date, 28), else: Date.add(as_date, 29)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    difference = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if difference < 1, do: 0, else: difference
  end

  def monday?(datetime), do: Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1

  def calculate_late_fee(checkout, return, rate) do
    planned_return = return_date(datetime_from_string(checkout))
    actual_return = datetime_from_string(return)
    lateness = days_late(planned_return, actual_return)
    if lateness < 1 do
      0
    else
      if monday?(actual_return), do: Float.floor(calculate_fee(lateness, rate / 2)), else: calculate_fee(lateness, rate)
    end
  end

  defp calculate_fee(lateness, rate) do
    lateness * rate
  end
end
