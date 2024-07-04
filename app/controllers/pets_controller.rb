class PetsController < ApplicationController
  def index
    if params[:id]
      shelter = Shelter.find_by(id: params[:id])
      @pets = shelter.pets
    else
      @pets = Pet.all
    end
  end

  def show
    @pet = Pet.find_by(id: params[:id])
  end
end