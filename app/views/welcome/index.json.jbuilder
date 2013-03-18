json._links do |j|
	j.self do |j|
		j.href welcome_index_url
	end
	j.crimes_years do |j|
		j.href api_years_url
	end
	j.crimes do |j|
		j.href api_crimes_url
	end
	j.crime_summary_by_year do |j|
		j.href api_by_year_index_url
	end
end