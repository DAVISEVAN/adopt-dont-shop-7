require 'rails_helper'

RSpec.describe 'New Adoption Application', type: :feature do
  it 'can start a new adoption application from the pet index page' do
    visit '/pets'

    # User Story 2: Start an Application
    click_link 'Start an Application'
    expect(current_path).to eq('/adoptions/new')

    within 'form' do
      fill_in 'Name', with: 'John Doe'
      fill_in 'Street Address', with: '123 Main Street'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip Code', with: '80202'
      fill_in 'Description', with: 'I have a big backyard and love animals.'
      click_button 'Submit'
    end

    new_adoption = Adoption.last
    expect(current_path).to eq("/adoptions/#{new_adoption.id}")

    within '#adoption-details' do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('123 Main Street')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('80202')
      expect(page).to have_content('I have a big backyard and love animals.')
    end

    within '#adoption-status' do
      expect(page).to have_content('In Progress')
    end
  end
end
