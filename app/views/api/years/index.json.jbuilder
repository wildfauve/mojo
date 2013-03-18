json.crimes @crimes do |json, c|
	json.(c, :offence)
	json.(c, :age_group)
	json.(c, :ethnicity)	
	json.(c, :gender)
	json.(c, :charge_outcome)	
end
json._links do |j|
	j.self api_years_url
	j.next {|j| j.href url_for(:controller => :years, :action => :index, :limit => @limit, :offset => @offset)}
	j.prev {|j| j.href url_for(:controller => :years, :action => :index, :limit => @limit, :offset => @old_offset)}		
	@years.each do |y|
		j.set!("#{y}", url_for(:controller => :years, :action => :show, :only_path => false, :id => y))
	end
end