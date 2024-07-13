require 'rails_helper'

RSpec.describe 'Adoption Show Page', type: :feature do
  before :each do
    @adoption = Adoption.create!(
      name: 'John Doe',
      street_address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80202',
      description: 'I have a big backyard and love animals.',
      status: 'In Progress'
    )
    
    @pet1 = Pet.create!(name: 'Dufus', breed: 'Mixed', age: 3, shelter_id: 1)
    @pet2 = Pet.create!(name: 'Snoopy', breed: 'Beagle', age: 5, shelter_id: 1)
    
    @adoption.pets << @pet1
    @adoption.pets << @pet2
  end

  it 'displays the adoption details' do
    visit adoption_path(@adoption)

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
        expect(page).to have_link(pet.name, href: pet_path(pet))
      end
    end
  end
end
