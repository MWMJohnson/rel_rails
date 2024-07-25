require "rails_helper"

RSpec.describe "pets/index.html.erb", type: :view do
  describe "user visits a specific shelter's pets index page" do 
    context 'happy path' do
      it "lets the user see a list of pets with their attributes from a selected shelter" do
        @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
        @pet1 = @shelter1.pets.create!(name:"Max", special_needs: false, age: 3)
        @pet2 = @shelter1.pets.create!(name:"Sam", special_needs: false, age: 12)
        
        @shelter2 = Shelter.create!(name: "VCA", non_profit: false, rank: 29)
        @pet3 = @shelter2.pets.create!(name:"Freddy", special_needs: true, age: 15)

        visit "/shelters/#{@shelter1.id}/pets"

        expect(page).to have_content(@pet2.name)
        expect(page).to have_content("Sam")

        expect(page).to have_content(@pet2.id)

        expect(page).to have_content(@pet2.special_needs)
        expect(page).to have_content(false)

        expect(page).to have_content(@pet2.age)
        expect(page).to have_content(12)

        expect(page).to have_content(@pet2.shelter.name)
        expect(page).to have_content("Rex's Kennel")
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet1.id)
        expect(page).to have_content(@pet1.special_needs)
        expect(page).to have_content(@pet1.age)
        expect(page).to have_content(@pet1.shelter.name)

        expect(page).to_not have_content("Name: #{@pet3.name}")
        expect(page).to_not have_content("ID: #{@pet3.id}")
        expect(page).to_not have_content("Special Needs? #{@pet3.special_needs}")
        expect(page).to_not have_content("Age: #{@pet3.age}")
        expect(page).to_not have_content("Shelter: #{@pet3.shelter}")
      end

      describe "Sort by Name link" do
        it "sorts the shelter's pet by name alphabeticallly" do
          @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)
          @pet1 = @shelter1.pets.create!(name:"Max", special_needs: false, age: 3)
          @pet2 = @shelter1.pets.create!(name:"Sam", special_needs: true, age: 12)
          @pet3 = @shelter1.pets.create!(name:"Freddy", special_needs: true, age: 15)
          @pet4 = @shelter1.pets.create!(name:"Bill", special_needs: false, age: 2)

          visit "shelters/#{@shelter1.id}/pets"

          within ".pets_list" do 
            expect("Name: Max").to appear_before("Name: Sam")
            expect("Name: Sam").to appear_before("Name: Freddy")
            expect("Name: Freddy").to appear_before("Name: Bill")
          end

          click_on "Sort by Name"

          expect(page).to have_current_path("/shelters/#{@shelter1.id}/pets?sort=true")

          within ".pets_list" do 
            expect("Name: Bill").to appear_before("Name: Freddy")
            expect("Name: Freddy").to appear_before("Name: Max")
            expect("Name: Max").to appear_before("Name: Sam")
          end
        end
      end

      describe "allows a user access to create a new pet" do
        context 'happy path' do
          it "redirects to a form to create a new pet under a shelter" do
            @shelter1 = Shelter.create!(name: "Rex's Kennel", non_profit: true, rank: 15)

            visit "/shelters/#{@shelter1.id}/pets"

            click_on "Create Pet"
            expect(page).to have_current_path "/shelters/#{@shelter1.id}/pets/new"
          end
        end
      end
    end
  end
end