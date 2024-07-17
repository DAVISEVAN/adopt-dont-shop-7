require 'rails_helper'

RSpec.describe 'Admin Shelters Index', type: :feature do
  before :each do
    @shelter1 = Shelter.create!(name: 'Crazy Cat Castle', city: 'Denver', foster_program: true, rank: 1)
    @shelter2 = Shelter.create!(name: 'Barking Mad Mansion', city: 'Boulder', foster_program: true, rank: 2)
    @shelter3 = Shelter.create!(name: 'Howling Heights', city: 'Aurora', foster_program: false, rank: 3)
  end

  it 'lists all shelters in reverse alphabetical order by name' do
    visit '/admin/shelters'

    within 'table tbody' do
      shelter_names = all('tr').map { |row| row.find('td:first-child').text }
      expect(shelter_names).to eq(['Howling Heights', 'Crazy Cat Castle', 'Barking Mad Mansion'].sort.reverse)
    end
  end
end
