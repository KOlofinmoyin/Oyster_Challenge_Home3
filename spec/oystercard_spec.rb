require 'oystercard'

describe Oystercard do
  it "returns balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

describe "#top_up" do
  it "adds one to my card balance" do
    expect { subject.top_up 1}.to change{ subject.balance}.by 1
  end
end
end
