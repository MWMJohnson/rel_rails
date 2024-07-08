class SheltersController < ApplicationController
  def index
    @shelters = Shelter.order(created_at: :desc)
  end

  def show
    @shelter = Shelter.find_by(id: params[:id])
  end

  def new
    @shelter = Shelter.new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to shelters_path
    else
      render :new, status: :unprocessable_entity
    end
    # require 'pry'; binding.pry
  end


  private

  def shelter_params
    params.require(:shelter).permit(:name, :non_profit, :rank)
  end
end