class Gender
  attr_accessor :type, :count
  
  def initialize(type, count)
    @type = type
    @count = count
  end
end