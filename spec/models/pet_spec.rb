require "rails_helper"

RSpec.describe Pet, type: :model do
  describe "Class Methods" do
    describe ".needy_pets" do
      it "returns a list of pets with special needs" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: true, age: 11)
        @pet2 = @shelter1.pets.create!(name:"Sam", special_needs: true, age: 12)
        @pet3 = @shelter1.pets.create!(name:"Abe", special_needs: false, age: 13)
        @pet4 = @shelter1.pets.create!(name:"Bob", special_needs: true, age: 15)
        @pet5 = @shelter1.pets.create!(name:"Bill", special_needs: false, age: 6)


        expect(Pet.all).to eq [@pet1, @pet2, @pet3, @pet4, @pet5]
        expect(Pet.needy_pets).to eq [@pet1, @pet2, @pet4]
      end
    end
    describe ".alphabetize" do
      it "returns a list of pets in order of name alphabetically" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: true, age: 11)
        @pet2 = @shelter1.pets.create!(name:"Sam", special_needs: true, age: 12)
        @pet3 = @shelter1.pets.create!(name:"Abe", special_needs: false, age: 13)
        @pet4 = @shelter1.pets.create!(name:"Bob", special_needs: true, age: 15)
        @pet5 = @shelter1.pets.create!(name:"Bill", special_needs: false, age: 6)


        expect(Pet.all).to eq [@pet1, @pet2, @pet3, @pet4, @pet5]
        expect(Pet.alphabetize).to eq [@pet3, @pet5, @pet4, @pet1, @pet2]
      end
    end
  end
end
        
        