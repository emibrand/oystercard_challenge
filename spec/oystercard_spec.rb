require 'oystercard'

describe Oystercard do

  it 'has a default balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe 'top_up' do

    it 'can top up balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'should not exceed max limit' do
      expect{ subject.top_up(Oystercard::MAX_LIMIT +1) }.to raise_error("Exceeded top-up amount of #{Oystercard::MAX_LIMIT}")
    end
  end
end