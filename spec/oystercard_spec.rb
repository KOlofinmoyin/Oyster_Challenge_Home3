require 'oystercard'

describe Oystercard do
subject(:my_card) { Oystercard.new }
let(:entry_station) { double(:entry_station) }
let(:exit_station) { double(:exit_station) }


    context "#top_up" do
      it "accepts an amount as a single argument" do
        expect(my_card).to respond_to(:top_up).with(1).argument
      end

      it "calculates it's starting balance" do
        expect(my_card.balance).to eq 0
      end

      it "adds money to my card" do
        expect{ my_card.top_up 10 }.to change{ my_card.balance }.by 10
      end


      it "adds a maximum limit (of £90) on my card" do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        my_card.top_up(maximum_balance)
        expect{ my_card.top_up(1) }.to raise_error "Cannot top up: £#{maximum_balance} exceeded"
      end
    end

    context "#touch_in" do
      it "raises an error when minimum amount is less than £1 for a single journey" do
        expect{ my_card.touch_in(entry_station) }.to raise_error "Insufficient minimum balance."
      end

      it "checks that the card has an empty list of journeys by default" do
        my_card.top_up(20)
        my_card.touch_in(entry_station)
        expect(my_card.journeys).to be_empty
      end

      it "allows me touch_in" do
        my_card.top_up(20)
        expect(my_card).to respond_to :touch_in
      end

      it "confirms I'm #in_journey when I touch_in" do
        my_card.top_up(20)
        my_card.touch_in(entry_station)
        expect(my_card).to be_in_journey
      end

      it "remembers the current entry station" do
        my_card.top_up(20)
        my_card.touch_in(entry_station)
        expect(my_card.entry_station).to eq entry_station
      end


    end

    context "#touch_out" do
      it "ends my current journey" do
        my_card.top_up(20)
        my_card.touch_in(entry_station)
        my_card.touch_out(exit_station)
        expect(my_card).not_to be_in_journey
      end

      it "reduces the amount by minimum fare" do
        my_card.top_up(20)
        my_card.touch_in(entry_station)
        expect { my_card.touch_out(exit_station) }.to change{ my_card.balance }.by -Oystercard::MINIMUM_BALANCE
      end

      it "checks that touching in and out creates one journey" do
        my_card.top_up(20)
        my_card.touch_in(entry_station)
        my_card.touch_out(exit_station)
        expect(my_card.journeys.count).to eq 1
      end

    end

end
