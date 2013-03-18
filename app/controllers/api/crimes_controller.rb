class Api::CrimesController < Api::ApplicationController
  
  def index
    
  end
  
  def create
    @crime = Crime.create_the_crime(params[:crime])
    respond_to do |format|
      if @crime.valid?
        format.json { render 'api/crimes/create', :status => :created, :location => url_for(api_crime_path(@crime)) }
      else
        format.json
      end
    end
  end
  
  
end
