class Crime
  @@per_page = 20
    
  include Mongoid::Document
  
  #include Tire::Model::Search
  #include Tire::Model::Callbacks
  
  after_save :create_dims
  
#  tire.mapping do
#    indexes :ref
#    indexes :offence
#    indexes :gender
#    indexes :ethnicity
#    indexes :court_location, :index => 'snowball'
#    indexes :age_group, :type => 'integer'
#    indexes :charge_outcome, :index => 'snowball'
#    indexes :year, :type => 'integer'
#  end
  
  field :ref, :type => Integer
  field :offence, :type => String
  field :gender, :type => String
  field :ethnicity, :type => String
  field :court_location, :type => String
  field :age_group, :type => String
  field :charge_outcome, :type => String
  field :year, :type => Integer
  
  def self.search(params)
    page = params[:page] || "1"
    #Rails.logger.info(">>>CARDS MODEL SEARCH #{page}")
    doc_from = ((page.to_i - 1) * @@per_page)
    self.all.order_by([:year, :asc]).page(params[:page])
  end
  
  
  def self.create_the_crime(params)
    #raise Exceptions::InvalidProfileConfidence if 
    crime = new(params)
    crime.save!
    return crime
  end
  
  def self.crime_details_by_years(params, limit, offset)
    year = params[:id]
    if year
      return Crime.where(:year => year).offset(offset).limit(limit)
    else
      return Crime.all.offset(offset).limit(limit)
    end
  end
  
  private
  
  def create_dims
    Dimension.new(self).update_dim
  end
  
end