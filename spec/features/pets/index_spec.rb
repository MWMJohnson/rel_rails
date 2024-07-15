require "rails_helper"

RSpec.describe "/pets/index.html.erb", type: :view do
  describe 'user visits pet index page' do 
    context 'happy path' do
      it "lets the user see a list of pets with their attributes" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)

        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: true, age: 3)
        @pet2 = @shelter2.pets.create!(name:"Sam", special_needs: true, age: 12)

        visit pets_path

        expect(page).to have_content("Pets")
        
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content("Max")

        expect(page).to have_content(@pet1.id)

        expect(page).to have_content(@pet1.special_needs)
        expect(page).to have_content(true)

        expect(page).to have_content(@pet1.age)
        expect(page).to have_content(3)

        expect(page).to have_content(@pet1.shelter.name)
        expect(page).to have_content("Rex's Kennel")

        expect(page).to have_content(@pet2.name)
        expect(page).to have_content("Sam")

        expect(page).to have_content(@pet2.id)

        expect(page).to have_content(@pet2.special_needs)
        expect(page).to have_content(true)

        expect(page).to have_content(@pet2.age)
        expect(page).to have_content(12)

        expect(page).to have_content(@pet2.shelter.name)
        expect(page).to have_content("VCA")
      end

      it "only displays pets with special needs" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)

        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: true, age: 11)
        @pet2 = @shelter1.pets.create!(name:"Sam", special_needs: true, age: 12)
        @pet3 = @shelter1.pets.create!(name:"Abe", special_needs: false, age: 13)
        @pet4 = @shelter1.pets.create!(name:"Bob", special_needs: true, age: 15)
        @pet5 = @shelter1.pets.create!(name:"Bill", special_needs: false, age: 6)


        visit "/pets" 
        
        within ".pets_list" do 
          expect(page).to have_content("Name: #{@pet1.name}")
          expect(page).to have_content("Special Needs? #{@pet1.special_needs}")
          expect(page).to have_content("Age: #{@pet1.age}")

          expect(page).to have_content("Name: #{@pet2.name}")
          expect(page).to have_content("Name: #{@pet4.name}")

          expect(page).to_not have_content("Name: #{@pet3.name}")
          expect(page).to_not have_content("Name: #{@pet5.name}")
        end
      end
    end
  end
end