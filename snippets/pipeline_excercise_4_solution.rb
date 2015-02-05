bands = [ {name: 'sunset rubdown', country: 'UK', active: false},
          {name: 'women', country: 'Germany', active: false},
          {name: 'a silver mt. zion', country: 'Spain', active: true} ]

def set_canada_as_country(band)
  return band.merge country: 'Canada'
end
set_canada_as_country = method :set_canada_as_country

def strip_punctuation_from_name(band)
  return band.merge name: band[:name].delete('.')
end
strip_punctuation_from_name = method :strip_punctuation_from_name
                      
def capitalize_names(band)
  return band.merge name: band[:name].upcase
end
capitalize_names = method :capitalize_names

def pipeline_each(bands, funcs)
  bands.map {|band| funcs.inject(band) {|b, f| b = f[b]}}
end

# Much more descriptive than format_bands(bands)
p pipeline_each(bands, [set_canada_as_country,
                        strip_punctuation_from_name,
                        capitalize_names])

# => [{:name=>"SUNSET RUBDOWN", :country=>"Canada", :active=>false}, 
#     {:name=>"WOMEN", :country=>"Canada", :active=>false}, 
#     {:name=>"A SILVER MT ZION", :country=>"Canada", :active=>true}]
