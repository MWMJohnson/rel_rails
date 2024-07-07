require "rails_helper"

RSpec.describe "pets/index.html.erb", type: :view do
  describe "user visits a specific shelter's pets index page" do 
    context 'happy path' do
      it "lets the user see a list of pets with their attributes from a selected shelter" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: false, age: 3)
        @pet2 = @shelter1.pets.create!(name:"Sam", special_needs: false, age: 12)
        
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
        @pet3 = @shelter2.pets.create!(name:"Freddy", special_needs: true, age: 15)

        visit "/shelters/#{@shelter1.id}/pets"

        expect(page).to have_content(@pet2.name)
        expect(page).to have_content("Sam")

        expect(page).to have_content(@pet2.id)

        expect(page).to have_content(@pet2.special_needs)
        expect(page).to have_content(false)

        expect(page).to have_content(@pet2.age)
        expect(page).to have_content(12)

        expect(page).to have_content(@pet2.shelter.name)
        expect(page).to have_content("Rex's Kennel")

        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet1.id)
        expect(page).to have_content(@pet1.special_needs)
        expect(page).to have_content(@pet1.age)
        expect(page).to have_content(@pet1.shelter.name)

        expect(page).to_not have_content(@pet3.name)
        expect(page).to_not have_content(@pet3.id)
        expect(page).to_not have_content(@pet3.special_needs)
        expect(page).to_not have_content(@pet3.age)
        expect(page).to_not have_content(@pet3.shelter.name)
      end
    end
  end
end