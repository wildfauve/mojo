class Api::ByYearController < Api::ApplicationController
  
  def index
    @years = Dimension.by_year
  end
  
  def show
    
  end
  
end