json.year params[:id]
json.crimes @crimes do |json, c|
	json.(c, :offence)
	json.(c, :age_group)
	json.(c, :ethnicity)	
	json.(c, :gender)
	json.(c, :charge_outcome)	
end
json._links do |j|
  j.next {|j| j.href url_for(:host => 'localhost', :controller => :years, :action => :show, :id => params[:id], :limit => @limit, :offset => @offset)}
  j.prev {|j| j.href url_for(:host => 'localhost', :controller => :years, :action => :show, :id => params[:id], :limit => @limit, :offset => @offset)}
	j.up {|j| j.href api_years_url}
end