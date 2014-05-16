require "toml"

state_abbr = {
  'AL' => 'Alabama','AK' => 'Alaska','AS' => 'America Samoa','AZ' => 'Arizona','AR' => 'Arkansas','CA' => 'California','CO' => 'Colorado','CT' => 'Connecticut','DE' => 'Delaware','DC' => 'District of Columbia','FM' => 'Micronesia1','FL' => 'Florida','GA' => 'Georgia','GU' => 'Guam','HI' => 'Hawaii','ID' => 'Idaho','IL' => 'Illinois','IN' => 'Indiana','IA' => 'Iowa','KS' => 'Kansas','KY' => 'Kentucky','LA' => 'Louisiana','ME' => 'Maine','MH' => 'Islands1','MD' => 'Maryland','MA' => 'Massachusetts','MI' => 'Michigan','MN' => 'Minnesota','MS' => 'Mississippi','MO' => 'Missouri','MT' => 'Montana','NE' => 'Nebraska','NV' => 'Nevada','NH' => 'New Hampshire','NJ' => 'New Jersey','NM' => 'New Mexico','NY' => 'New York','NC' => 'North Carolina','ND' => 'North Dakota','OH' => 'Ohio','OK' => 'Oklahoma','OR' => 'Oregon','PW' => 'Palau','PA' => 'Pennsylvania','PR' => 'Puerto Rico','RI' => 'Rhode Island','SC' => 'South Carolina','SD' => 'South Dakota','TN' => 'Tennessee','TX' => 'Texas','UT' => 'Utah','VT' => 'Vermont','VI' => 'Virgin Island','VA' => 'Virginia','WA' => 'Washington','WV' => 'West Virginia','WI' => 'Wisconsin','WY' => 'Wyoming'
}

Dir.glob("**/*").each do |path|
  next if File.directory?(path)
  next if path == "LICENSE" || path == "README.md" || path == "add_state.rb"

  hash = TOML.load_file path
  hash["state_code_alpha2"] = hash["state"]
  hash["state"] = state_abbr[hash["state_code_alpha2"]] || ""

  File.open(path, "wb") do |file|
    file.write(TOML::Generator.new(hash).body)
  end
end
