require "rails_helper"

RSpec.describe "shelters/show.html.erb", type: :view do
  describe 'user visits show page' do 
    context 'happy path' do
      it "lets the user view a selected shelter's pets" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
        
        visit "/shelters/#{@shelter1.id}"

        expect(page).to have_content(@shelter1.name)
        expect(page).to have_content("Rex's Kennel")

        expect(page).to have_content(@shelter1.non_profit)
        expect(page).to have_content(true)

        expect(page).to have_content(@shelter1.rank)
        expect(page).to have_content(15)

        expect(page).to_not have_content(@shelter2.name)
        expect(page).to_not have_content(@shelter2.non_profit)
        expect(page).to_not have_content(@shelter2.rank)
      end

      it "displays the number of pets availabe" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @pet2 = @shelter1.pets.create!(name:"Sam", special_needs: false, age: 12)
        visit "/shelters/#{@shelter1.id}"
        expect(page).to have_content("Number of pets available: 1")

        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
        @pet1 = @shelter2.pets.create!(name:"Max", special_needs: false, age: 3)
        @pet3 = @shelter2.pets.create!(name:"Freddy", special_needs: true, age: 15)
        visit "/shelters/#{@shelter2.id}"
        expect(page).to have_content("Number of pets available: 2")

        @shelter3 = Shelter.create!(name: "Cool Cats", non_profit: true, rank: 10)
        visit "/shelters/#{@shelter3.id}"
        expect(page).to have_content("Number of pets available: 0")
      end
    end
  end
  
end