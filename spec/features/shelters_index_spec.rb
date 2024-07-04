require "rails_helper"

RSpec.describe "shelters/index.html.erb", type: :view do
  describe 'user visits index page' do 
    context 'happy path' do
      it "lets the user see a list of all shelters" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
        
        visit shelters_path
        
        expect(page).to have_content("Shelters")

        expect(page).to have_content(@shelter1.name)
        expect(page).to have_content("Rex's Kennel") 
        expect(page).to have_content(@shelter2.name)
        expect(page).to have_content("VCA")
      end
    end
  end
  
end