require 'oystercard'

describe Oystercard do

  it 'has a default balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'can top up balance' do
      expect { subject.top_up 10 }.to change { subject.balance }.by 10
    end

    it 'raise error if reached max limit' do
      max_limit = Oystercard::MAX_LIMIT 
      error_msg = "Pound #{max_limit} limit reached!"
      subject.top_up(max_limit)
      expect { subject.top_up(10) }.to raise_error(error_msg)
    end
  end

  describe '#deduct' do
    it 'can deduct from balance' do
      subject.top_up(20)
      expect { subject.deduct 10 }.to change {subject.balance }.by -10
    end
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  # before(:each) do
  #   subject.top_up(Oystercard::MAX_LIMIT)
  # end

  it "can touch in" do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "can touch out" do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end