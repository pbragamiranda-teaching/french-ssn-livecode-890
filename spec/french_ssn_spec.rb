require_relative "../french_ssn"

describe "#french_ssn_info" do
  it "should return 'not a valid ssn' if empty string is given" do
  	actual = french_ssn_info(" ")
  	expect = "not a valid ssn"
    expect(actual).to eq(expect)
  end

  it "shold return 'a man, born in December, 1984 in Seine-Maritime.' if proper ssn is given" do
  	actual = french_ssn_info("1 84 12 76 451 089 46")
  	expect = "a man, born in December, 1984 in Seine-Maritime."
  	expect(actual).to eq(expect)
  end
end
