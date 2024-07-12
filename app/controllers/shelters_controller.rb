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
  end

  def edit
    @shelter = Shelter.find_by(id: params[:id])
  end

  def update
    @shelter = Shelter.find_by(id: params[:id])
    if @shelter.update!(shelter_params)
      redirect_to "/shelters/#{@shelter.id}"
    else
      render :edit
    end
  end


  private

  def shelter_params
    params.require(:shelter).permit(:name, :non_profit, :rank)
  end
end