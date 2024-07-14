require "rails_helper"

RSpec.describe "pets/edit.html.erb", type: :view do
  describe "allows a user to edit an existing pet" do
    context 'happy path' do
      it "updates the pet's attributes based on the user input" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: false, age: 3)

        expect(@pet1.name).to eq "Max"
        expect(@pet1.special_needs).to be false
        expect(@pet1.age).to eq 3
        
        visit "/pets/#{@pet1.id}/edit"

        within ".edit_pets_form" do 
          expect(page).to have_content("Name:")
          fill_in "Name:", with: "Lucy"
      
          expect(page).to have_content("Special Needs?:")
          check "Special Needs?:"
      
          expect(page).to have_content("Age:")
          fill_in "Age:", with: 6
      
          click_on "Update Pet"
        end
        
        expect(page).to have_current_path("/pets/#{@pet1.id}")

        updated_pet = Pet.find_by(id: @pet1.id)

        within ".pet_name" do
          expect(page).to have_content("#{updated_pet.name}")
          expect(updated_pet.name).to eq "Lucy"
        end

        expect(page).to have_content("ID: #{updated_pet.id}")

        expect(page).to have_content("Special Needs? #{updated_pet.special_needs}")
        expect(updated_pet.special_needs).to be true

        expect(page).to have_content("Age: #{updated_pet.age}")
        expect(updated_pet.age).to eq 6

        expect(page).to have_content("Shelter: #{updated_pet.shelter.name}")
      end
    end
  end
end