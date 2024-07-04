require "rails_helper"

RSpec.describe "shelters/index.html.erb", type: :view do
  describe 'user visits shelters index page' do 
    context 'happy path' do
      it "lets the user see a list of all shelter's names" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
        
        visit shelters_path
        
        expect(page).to have_content("Shelters")

        expect(page).to have_content(@shelter1.name)
        expect(page).to have_content("Rex's Kennel") 
        expect(page).to have_content(@shelter2.name)
        expect(page).to have_content("VCA")
      end

      it "displays shelters based on most recently added" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
        @shelter3 = Shelter.create!(name: "Cool Cats", non_profit: true, rank: 10)
        @shelter4 = Shelter.create!(name: "Homes4dogs", non_profit: true, rank: 1)

        visit shelters_path

        expect(page).to have_content(@shelter4.created_at)

        expect(@shelter4.name).to appear_before @shelter3.name
        expect(page).to have_content(@shelter3.created_at)

        expect(@shelter3.name).to appear_before @shelter2.name
        expect(page).to have_content(@shelter2.created_at)

        expect(@shelter2.name).to appear_before @shelter1.name
        expect(page).to have_content(@shelter1.created_at)
      end
    end
  end
  
end