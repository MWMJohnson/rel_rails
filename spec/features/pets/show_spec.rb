require "rails_helper"

RSpec.describe "pets/show.html.erb", type: :view do
  describe 'user visits show page' do 
    context 'happy path' do
      it "lets the user view details on a selected pet" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)

        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: false, age: 3)
        @pet2 = @shelter2.pets.create!(name:"Sam", special_needs: true, age: 12)

        visit "/pets/#{@pet1.id}"

        expect(page).to have_content(@pet1.name)
        expect(page).to have_content("Max")

        expect(page).to have_content(@pet1.id)

        expect(page).to have_content(@pet1.special_needs)
        expect(page).to have_content(false)

        expect(page).to have_content(@pet1.age)
        expect(page).to have_content(3)

        expect(page).to have_content(@pet1.shelter.name)
        expect(page).to have_content("Rex's Kennel")

        expect(page).to_not have_content(@pet2.name)
        expect(page).to_not have_content(@pet2.id)
        expect(page).to_not have_content(@pet2.special_needs)
        expect(page).to_not have_content(@pet2.age)
        expect(page).to_not have_content(@pet2.shelter)
      end
    end
  end

  describe "allows a user access to edit an existing pet" do
    context 'happy path' do
      it "updates the pet's attributes based on the user input" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: false, age: 3)

        visit "/pets/#{@pet1.id}"

        click_on "Update Pet"

        expect(page).to have_current_path("/pets/#{@pet1.id}/edit")
      end
    end
  end
end
