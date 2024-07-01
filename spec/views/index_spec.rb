require "rails_helper"

RSpec.describe "shelters/index.html.erb", type: :view do
  describe 'user visits index page' do 
    context 'happy path' do
      it "lets the user see a list of all shelters" do
        visit shelters_path

        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 15)
        expect(page).to have_content(@shelter1.name).to eq "Rex's Kennel"

        expect(page).to have_content(@shelter1.non_profit).to be true
        expect(page).to have_content(@shelter1.rank).to eq 15

        expect(page).to have_content(@shelter2.name).to eq "VCA"
        expect(page).to have_content(@shelter2.non_profit).to be false
        expect(page).to have_content(@shelter2.rank).to eq 29
      end
    end
  end
end