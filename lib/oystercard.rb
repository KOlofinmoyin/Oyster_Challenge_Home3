
class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

    def initialize
      @balance = 0
      @journeys = []
      @journey = {}
    end

    def top_up(credit)
      fail "Cannot top up: £#{MAXIMUM_BALANCE} exceeded" if credit + balance > MAXIMUM_BALANCE

       @balance += credit
    end

    def in_journey?
      @entry_station
    end

    def touch_in(entry_station)
      fail "Insufficient minimum balance." if @balance < MINIMUM_BALANCE

      @entry_station = entry_station
    end

    def touch_out(exit_station)
      deduct(MINIMUM_BALANCE)
      @exit_station = exit_station
      @journey[@entry_station] = @exit_station
      @journeys << @journey
      @entry_station = nil
    end

private
    def deduct(debit)
      @balance -= debit
    end

end
