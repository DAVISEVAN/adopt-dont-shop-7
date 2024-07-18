# User story 12 : approving applications

require 'rails_helper'

RSpec.describe 'Admin Adoption Show Page', type: :feature do
  before :each do
    @shelter = Shelter.create!(name: 'Homeless Shelter', city: 'Denver', foster_program: true, rank: 1)
    @pet1 = Pet.create!(name: 'Doofus', breed: 'Mixed', age: 3, shelter: @shelter)
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

  it 'can approve a pet for adoption' do
    visit "/admin/adoptions/#{@adoption.id}"

    within "#pet-#{@pet1.id}" do
      click_button 'Approve Pet'
    end

    expect(current_path).to eq("/admin/adoptions/#{@adoption.id}")

    within "#pet-#{@pet1.id}" do
      expect(page).to have_content('Approved')
      expect(page).not_to have_button('Approve Pet')
    end
  end

  it 'can reject a pet for adoption' do
    visit "/admin/adoptions/#{@adoption.id}"

    within "#pet-#{@pet1.id}" do
      click_button 'Reject Pet'
    end

    expect(current_path).to eq("/admin/adoptions/#{@adoption.id}")

    within "#pet-#{@pet1.id}" do
      expect(page).to have_content('Rejected')
      expect(page).not_to have_button('Approve Pet')
      expect(page).not_to have_button('Reject Pet')
    end
  end
end
