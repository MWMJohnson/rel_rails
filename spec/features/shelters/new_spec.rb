require "rails_helper"

RSpec.describe "pets/index.html.erb", type: :view do
  describe "allows a user to create a new shelter" do
    context 'happy path' do
      it "creates a new shelter in the database and redirects to the shelters index page" do 
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
      
        current_shelter_i = Shelter.count
      
        expect(current_shelter_i).to eq 2
        visit "/shelters/new"
      
        within ".new_shelter_form" do 
          expect(page).to have_content("Name:")
          fill_in "Name:", with: "Dumb Friends League"
      
          expect(page).to have_content("Nonprofit?:")
          check "Nonprofit?:"
      
          expect(page).to have_content("Rank:")
          fill_in "Rank:", with: 20
      
          click_on "Create Shelter"
        end
      
        expect(page).to have_current_path(shelters_path)
        current_shelter_i = Shelter.count
        expect(current_shelter_i).to eq 3
        
        new_shelter = Shelter.last
        expect(new_shelter.name).to eq "Dumb Friends League"
        expect(new_shelter.non_profit).to eq true
        expect(new_shelter.rank).to eq 20
      end
    end
  end
end

