# Admin Adoption Show Page 
require 'rails_helper'

RSpec.describe 'Admin Adoption Show Page', type: :feature do
  before :each do
    @shelter = Shelter.create!(name: 'Homeless Shelter', city: 'Denver', foster_program: true, rank: 1)
    @pet1 = Pet.create!(name: 'Doofus', breed: 'Mixed', age: 3, shelter: @shelter)
    @pet2 = Pet.create!(name: 'Snoopy', breed: 'Beagle', age: 5, shelter: @shelter)
    
    @adoption1 = Adoption.create!(
      name: 'John Doe',
      street_address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80202',
      description: 'I have a big backyard and love animals.',
      status: 'In Progress'
    )
    @adoption2 = Adoption.create!(
      name: 'Jane Smith',
      street_address: '456 Elm Street',
      city: 'Boulder',
      state: 'CO',
      zip_code: '80301',
      description: 'I love pets and have a lot of free time.',
      status: 'In Progress'
    )
    AdoptionPet.create!(adoption: @adoption1, pet: @pet1)
    AdoptionPet.create!(adoption: @adoption2, pet: @pet1)
  end

  # User Story 12: Approving a Pet for Adoption
  it 'can approve a pet for adoption' do
    visit "/admin/adoptions/#{@adoption1.id}"

    within "#pet-#{@pet1.id}" do
      click_button 'Approve Pet'
    end

    expect(current_path).to eq("/admin/adoptions/#{@adoption1.id}")

    within "#pet-#{@pet1.id}" do
      expect(page).to have_content('Approved')
      expect(page).not_to have_button('Approve Pet')
      expect(page).not_to have_button('Reject Pet')
    end

    # User Story 14: Approved/Rejected Pets on one Application do not affect other Applications
    visit "/admin/adoptions/#{@adoption2.id}"

    within "#pet-#{@pet1.id}" do
      expect(page).not_to have_content('Approved')
      expect(page).to have_button('Approve Pet')
      expect(page).to have_button('Reject Pet')
    end
  end

  # User Story 13: Rejecting a Pet for Adoption
  it 'can reject a pet for adoption' do
    visit "/admin/adoptions/#{@adoption1.id}"

    within "#pet-#{@pet1.id}" do
      click_button 'Reject Pet'
    end

    expect(current_path).to eq("/admin/adoptions/#{@adoption1.id}")

    within "#pet-#{@pet1.id}" do
      expect(page).to have_content('Rejected')
      expect(page).not_to have_button('Approve Pet')
      expect(page).not_to have_button('Reject Pet')
    end

    # User Story 14: Approved/Rejected Pets on one Application do not affect other Applications
    visit "/admin/adoptions/#{@adoption2.id}"

    within "#pet-#{@pet1.id}" do
      expect(page).not_to have_content('Rejected')
      expect(page).to have_button('Approve Pet')
      expect(page).to have_button('Reject Pet')
    end
  end
end
