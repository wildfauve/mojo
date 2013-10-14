class Year

  @@gender_cats = []
  @@offence_cats = []

  attr_accessor :key

# @dim => {:count => n, :gender => {:male => n}, :offense => {:off1 => n, :off2 => n}, :eth => {}, :age_g => {}}
  
  def self.find_and_store(crime)
    return self.find(crime.year).store_crime(crime).inc
  end
  
  def self.find(year)
    key = "year-#{year}"
      dim = $redis.get(key)
    dim.nil? ? dim_hash = {} : dim_hash = JSON.parse(dim)
    Rails.logger.info(">>>Year#Find: #{key} #{dim_hash["count"]}")    
    return Year.new(year, key, dim_hash)    
  end

  def self.by_year
    crime_years = Crime.all.distinct(:year)
    all_years = []
    crime_years.each do |y|
      year = self.find(y)
      self.gender_cats = year.genders.collect {|f| f.type}
      self.offence_cats = year.offences.collect {|f| f.type}
      all_years << year
    end
    all_years
  end
  
  def self.gender_cats
    @@gender_cats 
  end
  
  def self.gender_cats=(genders)
    @@gender_cats.concat(genders).uniq!
  end

  def self.offence_cats
    @@offence_cats 
  end
  
  def self.offence_cats=(offences)
    @@offence_cats.concat(offences).uniq!
  end
  
  def initialize(id, key, dim=nil)
    @id = id
    @key = key
    if !dim.empty?      
      @dim = dim
    else
      @dim = {"count" => 0,
              "gender" => {},
              "ethnicity" => {},
              "court_location" => {},
              "age_group" => {},
              "charge_outcome" => {},
              "offence" => {}}
    end
  end
  
  def store_crime(crime)
      @year = crime.year
      @gender = crime.gender
      @eth = crime.ethnicity
      @cl = crime.court_location
      @age = crime.age_group
      @chr = crime.charge_outcome
      @off = crime.offence
      return self
  end
    
  def inc
    @dim["count"] += 1  # add to count
    @dim["gender"] = inc_item(@dim["gender"], @gender)
    @dim["ethnicity"] = inc_item(@dim["ethnicity"], @eth)
    @dim["court_location"] = inc_item(@dim["court_location"], @cl)
    @dim["age_group"] = inc_item(@dim["age_group"], @age)
    @dim["charge_outcome"] = inc_item(@dim["charge_outcome"], @chr)
    @dim["offence"] = inc_item(@dim["offence"], @off)        
    self.store
  end
  
  def inc_item(count_hash, key)
    count_hash.has_key?(key) ? count_hash[key] += 1 : count_hash[key] = 1
    return count_hash
  end
  
  def store
    $redis.set @key, @dim.to_json
  end
    
  # attribute methods
  
  def year
    @id
  end
  
  def count
    @dim["count"]
  end
  
  def genders
    @gens = []
    @dim["gender"].each {|type,ct| @gens << Gender.new(type,ct)}
    @gens
  end
  
  def name
    "Year #{@id}"
  end
  
  def offences
    @offs = []
    @dim["offence"].each {|type,ct| @offs << Offence.new(type,ct)}
    @offs
  end
  
    

end