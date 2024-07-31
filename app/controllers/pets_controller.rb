class PetsController < ApplicationController

  def index
    if params[:id]
      @shelter = Shelter.find_by(id: params[:id])
      @pets = @shelter.pets
      if params[:threshold]
        @pets = @pets.filter_by_age(params[:threshold])
      end
      if params[:sort]
        @pets = @pets.alphabetize
      end
    else
      @pets = Pet.needy_pets
    end
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

  def show
    @pet = Pet.find_by(id: params[:id])
  end

  def edit
    @pet = Pet.find_by(id: params[:id])
  end

  def update
    pet = Pet.find_by(id: params[:id])
    if pet.update!(pet_params)
      redirect_to "/pets/#{pet.id}"
    else
      render :edit
    end
  end

  def destroy
    pet = Pet.find_by(id: params[:id])
    if pet
      pet.destroy
      redirect_to "/pets"
    else
      render :show
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :special_needs, :age)
  end
end