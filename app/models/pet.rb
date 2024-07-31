class Pet < ApplicationRecord
  belongs_to :shelter

  def self.needy_pets
    where(special_needs: true)
  end

  def self.alphabetize
    order(:name)
  end

  def self.filter_by_age(input)
    where("age > ?", input)
  end
end