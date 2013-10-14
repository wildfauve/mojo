class Dimension
  
  def self.by_year
    return Year.by_year
  end


  def initialize(model)
    Rails.logger.info(">>>Dimension>>Init: #{model}")
    @crime = model
  end
  
  def update_dim
    y = Year.find_and_store(@crime)
  end  

  
end