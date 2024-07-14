require "rails_helper"

RSpec.describe "pets/new.html.erb", type: :view do
  describe "allows a user to create a new pet under a shelter" do
    context 'happy path' do
      it "has a form to fill in a new pet's attributes" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)

        current_pet_n = @shelter1.pets.count
      
        expect(current_pet_n).to eq 0

        visit "/shelters/#{@shelter1.id}/pets/new"

        expect(page).to have_current_path("/shelters/#{@shelter1.id}/pets/new")

        within ".new_shelter_pets_form" do 
          expect(page).to have_content("Name:")
          fill_in "Name:", with: "Lassie"
      
          expect(page).to have_content("Special Needs?:")
      
          expect(page).to have_content("Age:")
          fill_in "Age:", with: 5
      
          click_on "Create Pet"
        end
      
        expect(page).to have_current_path("/shelters/#{@shelter1.id}/pets")
        current_pet_n = @shelter1.pets.count
        expect(current_pet_n).to eq 1
        
        new_pet = @shelter1.pets.last
        expect(page).to have_content("Name: #{new_pet.name}")
        expect(page).to have_content("ID: #{new_pet.id}")
        expect(page).to have_content("Special Needs? #{new_pet.special_needs}")
        expect(page).to have_content("Age: #{new_pet.age}")
        expect(page).to have_content("Shelter: #{new_pet.shelter.name}")
      end
    end
  end
end