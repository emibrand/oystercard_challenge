class Oystercard
  
  attr_reader :balance
  
  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    max_topup_limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private
  
  def max_topup_limit
    raise "Pound #{MAX_LIMIT} limit reached!" if @balance >= MAX_LIMIT
  end
end