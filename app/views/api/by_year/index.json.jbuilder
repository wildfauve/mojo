json.title "Crime Year Dimensions"
json.gender_cats Year.gender_cats
json.offence_cats Year.offence_cats
json.years @years do |y|
  json.title y.name
  json.year y.year
  json.count y.count
  json.genders y.genders do |g|
    json.type g.type
    json.count g.count
  end
  json.offences y.offences do |o|
    json.type o.type
    json.count o.count
  end
end
json._links do |j|
  json.self api_by_year_index_url
end