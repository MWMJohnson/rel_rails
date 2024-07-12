require "rails_helper"

RSpec.describe "pets/index.html.erb", type: :view do
  describe "allows a user to edit an existing shelter" do
    context 'happy path' do
      it "edits an existing shelter in the database and redirects to the shelters index page" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
      
        expect(@shelter1.name).to eq "Rex's Kennel"
        expect(@shelter1.non_profit).to eq true
        expect(@shelter1.rank).to eq 15
        
        visit "/shelters/#{@shelter1.id}/edit"
      
        within ".edit_shelter_form" do
          expect(page).to have_content("Name:")
          fill_in "Name:", with: "New Shelter Name"
          expect(page).to have_content("Nonprofit?:")
          uncheck "Nonprofit?:"
          expect(page).to have_content("Rank:")
          fill_in "Rank:", with: 1020
          click_on "Edit Shelter"
        end
      
        expect(page).to have_current_path("/shelters/#{@shelter1.id}")
      
        expect(page).to have_content "Name: New Shelter Name"
        expect(page).to have_content "Nonprofit?: false"
        expect(page).to have_content "Rank: 1020"
      
        @shelter1.reload
        expect(@shelter1.name).to eq "New Shelter Name"
        expect(@shelter1.non_profit).to eq false
        expect(@shelter1.rank).to eq 1020
      end
    end
  end
end