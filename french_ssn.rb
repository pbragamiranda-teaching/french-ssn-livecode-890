require 'date'
require 'yaml'

SSN_PATTERN = /^(?<gender>1|2)\s*(?<year>\d{2})\s*(?<month>0[1-9]|1[0-2])\s*(?<zip>\d{2})\s*\d{3}\s*\d{3}\s*(?<code>\d{2})$/

def french_ssn_info(ssn)
	match_data = ssn.match(SSN_PATTERN)

	if match_data && valid_ssn_key?(ssn, match_data[:code])
		gender = set_gender(match_data[:gender])
		year = "19#{match_data[:year]}"
		month = Date::MONTHNAMES[match_data[:month].to_i]
		district = set_district(match_data[:zip])
		return "a #{gender}, born in #{month}, #{year} in #{district}."
	else
		return "not a valid ssn"	
	end
end

def set_gender(code)
	code == "1" ? "man" : "woman"
end

def set_district(code)
	YAML.load_file("data/french_departments.yml")[code]
end

# A 2 digits key (46, equal to the remainder of the division of (97 - ssn_without_key) by 97.)
def valid_ssn_key?(ssn, code)
	ssn_without_key = ssn.delete(" ")[0..12].to_i
	code.to_i == (97 - ssn_without_key) % 97
end


# french_ssn_info("1 84 12 76 451 089 46")