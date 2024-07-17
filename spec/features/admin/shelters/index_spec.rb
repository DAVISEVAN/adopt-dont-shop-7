require 'rails_helper'

RSpec.describe 'Admin Shelters Index', type: :feature do
  before :each do
    @shelter1 = Shelter.create!(name: 'Crazy Cat Castle', city: 'Denver', foster_program: true, rank: 1)
    @shelter2 = Shelter.create!(name: 'Barking Mad Mansion', city: 'Boulder', foster_program: true, rank: 2)
    @shelter3 = Shelter.create!(name: 'Howling Heights', city: 'Aurora', foster_program: false, rank: 3)

    @pet1 = Pet.create!(name: 'bubbles', breed: 'Cat', age: 3, shelter: @shelter1)
    @pet2 = Pet.create!(name: 'Budd', breed: 'Dog', age: 5, shelter: @shelter2)
    @pet3 = Pet.create!(name: 'Aldo', breed: 'Dog', age: 2, shelter: @shelter3)

    @adoption1 = Adoption.create!(name: 'John Doe', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'Loves animals', status: 'Pending')
    @adoption2 = Adoption.create!(name: 'Jane Smith', street_address: '456 Elm St', city: 'Boulder', state: 'CO', zip_code: '80301', description: 'Has a big yard', status: 'Approved')
    
    AdoptionPet.create!(adoption: @adoption1, pet: @pet1)
    AdoptionPet.create!(adoption: @adoption2, pet: @pet2)
  end
  #user story 10
  it 'lists all shelters in reverse alphabetical order by name' do
    visit '/admin/shelters'

    within 'table tbody' do
      shelter_names = all('tr').map { |row| row.find('td:first-child').text }
      expect(shelter_names).to eq(['Howling Heights', 'Crazy Cat Castle', 'Barking Mad Mansion'].sort.reverse)
    end
  end
  #user story 11
  it 'displays shelters with pending applications' do
    visit '/admin/shelters'

    within 'ul' do
      expect(page).to have_content('Crazy Cat Castle')
      expect(page).not_to have_content('Barking Mad Mansion')
      expect(page).not_to have_content('Howling Heights')
    end
  end
end
