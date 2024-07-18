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
    @pet1 = Pet.create!(name: 'Doofus', breed: 'Mixed', age: 3, shelter: @shelter)
    @pet2 = Pet.create!(name: 'Snoopy', breed: 'Beagle', age: 5, shelter: @shelter)
    @pet3 = Pet.create!(name: 'Mark', breed: 'Tabby', age: 2, shelter: @shelter)
    @pet4 = Pet.create!(name: 'Fluffy', breed: 'Poodle', age: 1, shelter: @shelter)
    @pet5 = Pet.create!(name: 'FLUFF', breed: 'Poodle', age: 1, shelter: @shelter)
    @pet6 = Pet.create!(name: 'Mr. FlUfF', breed: 'Poodle', age: 1, shelter: @shelter)

    @adoption = Adoption.create!(
      name: 'John Doe',
      street_address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80202',
      description: 'I have a big backyard and love animals.',
      status: 'In Progress'
    )
    @adoption_without_pets = Adoption.create!(name: "Jane Doe", street_address: "456 Maple St", city: "Boulder", state: "CO", zip_code: "80301", description: "Has a big backyard", status: "In Progress")
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

  # User Story 5: Adopt a Pet from Search Results
  it 'can adopt a pet from the search results' do
    visit "/adoptions/#{@adoption.id}"

    
    within '#add-pet' do
      fill_in 'Search for a Pet by Name', with: 'Snoopy'
      click_button 'Search'
    end

    within '#search-results' do
      expect(page).to have_link('Snoopy', href: "/pets/#{@pet2.id}")
      expect(page).to have_button('Adopt this Pet')
      click_button 'Adopt this Pet'
    end

    expect(current_path).to eq("/adoptions/#{@adoption.id}")

    within '#adoption-pets' do
      expect(page).to have_link('Snoopy', href: "/pets/#{@pet2.id}")
    end
  end

  # User Story 6: Submit an Application
  it 'can submit an application' do
    visit "/adoptions/#{@adoption.id}"

    within '#submit-application' do
      fill_in "Why would you make a good owner for these pets?", with: 'I have a big backyard and love animals.'
      click_button 'Submit Application'
    end

    expect(current_path).to eq("/adoptions/#{@adoption.id}")

    within '#adoption-status' do
      expect(page).to have_content('Pending')
    end

    within '#adoption-pets' do
      @adoption.pets.each do |pet|
        expect(page).to have_link(pet.name, href: "/pets/#{pet.id}")
      end
    end
    expect(page).not_to have_selector("#add-pet")
  end

  # User Story 7: No submit section if no pets added
  it 'does not show submit section if no pets are added' do
    visit "/adoptions/#{@adoption_without_pets.id}"

    
    expect(page).not_to have_selector('#submit-application')
  end

  # User Story 8: Partial matches in search
  it "can search for pets by name and display partial matches" do
    visit "/adoptions/#{@adoption.id}"

    within '#add-pet' do
      fill_in 'Search for a Pet by Name', with: 'Doo'
      click_button 'Search'
    end

    within '#search-results' do
      expect(page).to have_content('Doofus')
      expect(page).not_to have_content('Mark')
    end
  end
  # User Story 9: Case Insensitive Search
  it "can search for pets by name and display case insensitive matches" do
    visit "/adoptions/#{@adoption.id}"

    within '#add-pet' do
      fill_in 'Search for a Pet by Name', with: 'fluff'
      click_button 'Search'
    end

    within '#search-results' do
      expect(page).to have_content('Fluffy')
      expect(page).to have_content('FLUFF')
      expect(page).to have_content('Mr. FlUfF')
    end
  end
end
