class SheltersController < ApplicationController
  def index
    @shelters = Shelter.order(created_at: :desc)
  end

  def show
    @shelter = Shelter.find_by(id: params[:id])
  end
end