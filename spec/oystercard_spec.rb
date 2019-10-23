require 'oystercard'

describe Oystercard do

it "returns a balance of zero on my card" do
  expect(subject.balance).to eq 0
end

# In order to keep using public transport
# As a customer
# I want to add money to my card
it { is_expected.to respond_to(:top_up).with(1).argument}

it "adds some money to my card" do
  expect { subject.top_up(1) }.to change { subject.balance }.by 1
end

it "raises an error when I topup over the maximum allowable balance" do
  maximum_balance = Oystercard::MAXIMUM_BALANCE
  subject.top_up maximum_balance
  expect{ subject.top_up 1 }.to raise_error "Maximum balance of £#{maximum_balance} exceeded."
end

# In order to pay for my journey
# As a customer
# I need my fare deducted from my card
it "deducts a fare from my card" do
  expect { subject.deduct 1 }.to change{ subject.balance }.by(-1)
end

end
