json.title "Crime Year Dimensions"
json.gender_cats Year.gender_cats
json.offence_cats Year.offence_cats
json.years @years do |json, y|
  json.title y.name
  json.year y.year
  json.count y.count
  json.genders y.genders do |j, g|
    j.type g.type
    j.count g.count
  end
  json.offences y.offences do |j, o|
    j.type o.type
    j.count o.count
  end
end
json._links do |j|
  j.self api_by_year_index_url
end