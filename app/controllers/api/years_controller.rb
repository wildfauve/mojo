class Api::YearsController < Api::ApplicationController

  def index
    pages()
    @years = Crime.all.distinct(:year)
    Rails.logger.info(">>>API_Years_Index #{@limit}  #{@offset}")
    @crimes = Crime.crime_details_by_years(params, @limit, @offset)
    @offset += @limit
  end

  def show
    pages()
    @crimes = Crime.crime_details_by_years(params, @limit, @offset)
    @offset += @limit
    respond_to do |format|
      format.json 
    end
  end
  
  def pages
    @limit = params[:limit] || 5
    @old_offset = params[:offset]
    @offset = params[:offset] || 0
    @offset = @offset.to_i
    @limit = @limit.to_i    
  end
end