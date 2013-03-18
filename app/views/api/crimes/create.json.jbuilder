json.status "ok"
json.link url_for api_crime_path(@crime)
json.(@crime, :offence)
json.(@crime, :year)
