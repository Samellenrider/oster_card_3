require 'oystercard'

RSpec.describe Oystercard do
  subject { Oystercard.new }

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'checks if the Oyster has balance 0' do
    expect(subject.balance).to eq 0
  end

  it 'tops up with 1 argument' do
    expect(subject.respond_to?(:top_up)).to be true
  end

  it 'raises and error if we exceed the max limit' do
    oystercard = Oystercard.new
    value = oystercard.top_up(91)
    expect { oystercard.top_up(1) }.to raise_error('Top up limit exceeded!')
  end

  it 'checks if balance is bigger than max_value' do
    expect(subject.max?).not_to be true
  end

  it 'tells if we touched in' do
    subject.top_up(1)
    expect(subject.touch_in(:entry_station)).to eq true
  end

  it "tells we're in journey" do
    t = Oystercard.new
    t.top_up(1)
    t.touch_in(:entry_station)
    expect(t.in_journey?).to eq(true)
  end

  it 'tells if we touched out' do
    t = Oystercard.new
    t.top_up(1)
    t.touch_in(:entry_station)
    t.touch_out(:exit_station)
    expect(t.exit_station).to eq(:exit_station)
  end

  it 'error when touch in balance = 0' do
    t = Oystercard.new
    expect { t.touch_in(:entry_station) }.to raise_error 'Not enough money to travel.'
  end

  it 'reduces balance by minimal amount' do
    t = Oystercard.new
    t.top_up(1)
    expect { t.touch_out(:exit_station) }.to change { t.balance }.by(-1)
  end

  it 'adds origin destination' do
    t = Oystercard.new
    t.top_up(1)
    t.touch_in(:entry_station)
    expect(t.entry_station).to eq :entry_station
  end

  it 'tells card to set entry station nil' do
    t = Oystercard.new
    t.top_up(1)
    t.touch_in(:entry_station)
    t.touch_out(:exit_station)
    expect(t.entry_station).to eq nil
  end

  it 'have an empty list of journeys' do
    t = Oystercard.new
    t.top_up(1)
    expect(t.journey_list).to eq []
  end

  it 'checks if touching in + touching out creates journey' do
    t = Oystercard.new
    t.top_up(1)
    t.touch_in(:entry_station)
    t.touch_out(:exit_station)
    expect(t.journey_list).to eq t.journey_list.push(entry_station: :exit_station)
  end
end
