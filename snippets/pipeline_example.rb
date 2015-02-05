bands = [ {name: 'sunset rubdown', country: 'UK', active: false},
          {name: 'women', country: 'Germany', active: false},
          {name: 'a silver mt. zion', country: 'Spain', active: true} ]

def format_bands(bands)
  bands.each do |band|
    band[:country] = 'Canada'
    band[:name] = band[:name].delete('.')
    band[:name] = band[:name].upcase
  end
end

p format_bands(bands)
# => [{:name=>"SUNSET RUBDOWN", :country=>"Canada", :active=>false}, 
#     {:name=>"WOMEN", :country=>"Canada", :active=>false}, 
#     {:name=>"A SILVER MT ZION", :country=>"Canada", :active=>true}]
#
#     ...looks..fine
