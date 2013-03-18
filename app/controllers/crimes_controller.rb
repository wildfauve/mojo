class CrimesController < ApplicationController
  
  def index
    @crimes = Crime.search(params)
  end
  
end