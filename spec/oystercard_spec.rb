require 'oystercard'

describe Oystercard do
  it "returns zero balance" do
    expect(subject.balance).to eq 0
  end
end
