class Oystercard
  
  attr_reader :balance
  
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail "Exceeded top-up max amount of #{MAX_LIMIT}" if exceed_max?(amount)
    @balance += amount
  end

  private
  
  def exceed_max?(amount)
    @balance + amount > MAX_LIMIT
  end
end