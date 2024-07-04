require "rails_helper"

RSpec.describe "shelters/show.html.erb", type: :view do
  describe 'user visits show page' do 
    context 'happy path' do
      it "lets the user view details on a selected shelter" do
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
    end
  end
  
end