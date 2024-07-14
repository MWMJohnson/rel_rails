class PetsController < ApplicationController
  def index
    if params[:id]
      @shelter = Shelter.find_by(id: params[:id])
      @pets = @shelter.pets
    else
      @pets = Pet.all
    end
  end

  def show
    @pet = Pet.find_by(id: params[:id])
  end

  def new
    @shelter = Shelter.find_by(id: params[:id])
    @pet = @shelter.pets.new
  end
  
  def create
    shelter = Shelter.find_by(id: params[:id])
    if shelter.pets.new(pet_params).save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :special_needs, :age)
  end
end