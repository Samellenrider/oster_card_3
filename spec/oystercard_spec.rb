require 'oystercard'

describe Oystercard do
  subject { Oystercard.new }

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
    expect(subject.touch_in).to eq true
  end

  it "tells we're in journey" do
    t = Oystercard.new
    expect(t.in_journey?).to eq(t.in_use)
  end

  it 'tells if we touched out' do
    t = Oystercard.new
    expect(t.touch_out).not_to eq(t.in_use)
  end
  
  it "error when touch in balance = 0" do
    t = Oystercard.new
    expect{ t.touch_in }.to raise_error ("Not enough money to travel.")
  end

  it "reduces balance by minimal amount" do
    t =Oystercard.new
    expect { t.touch_out }.to change{t.balance}.by(-1)
  end
  
end
