class Oystercard

  attr_reader :balance, :in_journey, :entry_station, :journeys
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 2
  
  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Balance has reached limit of 90" if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Balance too low!' if balance < MIN_BALANCE
    @entry_station = station
  end

  def in_journey?
    !!entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_CHARGE)
    @journeys = { :entry_station=> @entry_station, :exit_station=>exit_station }
    @entry_station = nil
  end

  private 

  def deduct(amount)
    @balance -= amount
  end


  def deduct(amount)
    @balance -= amount
  end
end