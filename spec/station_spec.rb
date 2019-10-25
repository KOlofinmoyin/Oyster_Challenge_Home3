require 'station'

describe Station do
  subject(:underground_station) { described_class.new(name="Aldgate", zone= 1) }

  it "confirms a station has a name" do
    expect(underground_station.name).to eq "Aldgate"
  end

  it "confirms a station has a zone" do
    expect(underground_station.zone).to eq 1
  end

end
