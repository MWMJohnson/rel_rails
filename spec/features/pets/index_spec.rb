require "rails_helper"

RSpec.describe "pets/index.html.erb", type: :view do
  describe 'user visits pet index page' do 
    context 'happy path' do
      it "lets the user see a list of all pets with their attributes" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)

        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: false, age: 3)
        @pet2 = @shelter2.pets.create!(name:"Sam", special_needs: true, age: 12)

        visit pets_path

        expect(page).to have_content("Pets")
        
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content("Max")

        expect(page).to have_content(@pet1.special_needs)
        expect(page).to have_content(false)

        expect(page).to have_content(@pet1.age)
        expect(page).to have_content(3)

        expect(page).to have_content(@pet1.shelter.name)
        expect(page).to have_content("Rex's Kennel")

        expect(page).to have_content(@pet2.name)
        expect(page).to have_content("Sam")

        expect(page).to have_content(@pet2.special_needs)
        expect(page).to have_content(true)

        expect(page).to have_content(@pet2.age)
        expect(page).to have_content(12)

        expect(page).to have_content(@pet2.shelter.name)
        expect(page).to have_content("VCA")
      end
    end
  end
end