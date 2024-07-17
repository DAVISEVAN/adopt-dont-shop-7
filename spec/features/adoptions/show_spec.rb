require 'rails_helper'
# User story 1 
RSpec.describe 'Adoption Show Page', type: :feature do
  before :each do
    @shelter = Shelter.create!(
      name: 'Homeless Shelter', 
      city: 'Denver', 
      foster_program: true, 
      rank: 1
    )
    @pet1 = Pet.create!(name: 'Dufus', breed: 'Mixed', age: 3, shelter: @shelter)
    @pet2 = Pet.create!(name: 'Snoopy', breed: 'Beagle', age: 5, shelter: @shelter)
    
    @adoption = Adoption.create!(
      name: 'John Doe',
      street_address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80202',
      description: 'I have a big backyard and love animals.',
      status: 'In Progress'
    )

    AdoptionPet.create!(adoption: @adoption, pet: @pet1)
    AdoptionPet.create!(adoption: @adoption, pet: @pet2)
  end

  it 'displays the adoption details' do
    visit "/adoptions/#{@adoption.id}"

    within '#adoption-details' do
      expect(page).to have_content(@adoption.name)
      expect(page).to have_content(@adoption.street_address)
      expect(page).to have_content(@adoption.city)
      expect(page).to have_content(@adoption.state)
      expect(page).to have_content(@adoption.zip_code)
      expect(page).to have_content(@adoption.description)
    end

    within '#adoption-status' do
      expect(page).to have_content(@adoption.status)
    end

    within '#adoption-pets' do
      @adoption.pets.each do |pet|
        expect(page).to have_link(pet.name, href: "/pets/#{pet.id}")
      end
    end
  end
# User Story 4: Searching for Pets for an Application
  it 'can search for pets by name and display results' do
    visit "/adoptions/#{@adoption.id}"

    
    within '#add-pet' do
      fill_in 'Search for a Pet by Name', with: 'Snoopy'
      click_button 'Search'
    end

    expect(current_path).to eq("/adoptions/#{@adoption.id}")
    
    within '#search-results' do
      expect(page).to have_link('Snoopy', href: "/pets/#{@pet2.id}")
    end
  end
end
