class Pet < ApplicationRecord
  belongs_to :shelter

  def self.needy_pets
    where(special_needs: true)
  end
end