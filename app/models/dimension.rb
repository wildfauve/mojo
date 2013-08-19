class Dimension
  
  def self.by_year
    return Year.by_year
  end


  def initialize(model)
    Rails.logger.info(">>>Dimension>>Init: #{model}")
    @crime = model
  end
  
  def update_dim
    y = Year.find_store_inc(@crime)
  end  

  
end