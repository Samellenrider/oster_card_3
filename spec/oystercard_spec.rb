require 'oystercard'

describe Oystercard do
	subject { Oystercard.new }
	# let (:max_value) {double :max_value}

	it "checks if the Oyster has balance 0" do
		expect(subject.balance).to eq 0
	end

  it "tops up with 1 argument" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "raises and error if we exceed the max limit" do
  	expect(subject.top_up(1)).to raise_error("Top up limit exceeded!") if (:max? == true)
  end

end
