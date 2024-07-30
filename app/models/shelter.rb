class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy



  # Reminder on using #self
  # def non_profit_y_n
  #   self.non_profit ? "yes":"no"
  # end
end