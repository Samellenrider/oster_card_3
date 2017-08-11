class Station
  attr_reader :name, :zone

  def initialize(station_name, zone)
    @station_name = station_name
    @zone = zone
  end
end

MAX_VALUE = 90
MIN_VALUE = 1

class Oystercard
  attr_accessor :balance, :max_value, :journey_list

  def initialize(balance = 0, _in_use = false)
    @balance = balance
    @max_value = MAX_VALUE
    @journey_list = []
   end

  def top_up(value)
    raise 'Top up limit exceeded!' if max?
    @balance += value
    "£#{balance}"
   end

  def max?
    @balance >= max_value
   end

  def touch_in(station)
    if balance < MIN_VALUE
      raise 'Not enough money to travel.'
    else
      @journey_list.push({in: station, out: nil})
    end
  end
  end

  def in_journey?
    if @journey_list = [] || if @journey_list.last[:out] != nil #we are acccessing the last element of the array
      false
    else
      true
    end
  end

  def touch_out(station)
    deduct(MIN_VALUE)
    @journey_list.last[:out] = station
    @entry_station = nil
  end


private

  def deduct(amount)
    @balance -= amount
    balance
  end


end
