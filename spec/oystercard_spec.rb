require 'oystercard'

describe Oystercard do
  let(:entry_station){ double :station }
  let(:exit_station){ double :station}
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end

    it 'throws error if max balance is exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error "Balance has reached limit of #{max_balance}"
    end  
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'touch_in' do
    oyster = Oystercard.new(5)
    oyster.touch_in(entry_station)
    expect(oyster).to be_in_journey
  end

  it 'throws error if balance is less than 1' do
    expect{ subject.touch_in(entry_station) }.to raise_error "Balance too low!"
  end

  it 'touch_out' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'can reduce the balance by minimum fare' do
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
  end
  
  it 'stores the entry station' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect(subject.entry_station). to eq entry_station
  end

  it 'stores the exit station' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys[:exit_station]).to eq exit_station
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end
  
  it 'stores a journey' do
    subject.top_up(5)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

end