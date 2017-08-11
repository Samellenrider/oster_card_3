MAX_VALUE = 90
MIN_VALUE = 1

class Oystercard
  attr_accessor :balance, :max_value, :journey_list, :entry_station, :exit_station

  def initialize(balance = 0, _in_use = false, journey_list = [])
    @balance = balance
    @max_value = MAX_VALUE
    @journey_list = journey_list
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
      @entry_station = station
      true
    end
  end

  def in_journey?
    if !@entry_station.nil?
      true
    else
      false
    end
  end

  def touch_out(station)
    deduct(MIN_VALUE)
    @exit_station = station
    journey_list.push(@entry_station => @exit_station)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
    balance
  end
end



class Station

  def initialize(station_name, zone)
    @station_name = station_name
    @zone = zone





































