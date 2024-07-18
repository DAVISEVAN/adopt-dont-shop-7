# db/seeds.rb

# Destroy all previous data to start fresh
AdoptionPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
Adoption.destroy_all

# Shelters
shelter1 = Shelter.create!(name: 'Homeless Shelter', city: 'Denver', foster_program: true, rank: 1)
shelter2 = Shelter.create!(name: 'Pet Paradise', city: 'Boulder', foster_program: false, rank: 2)
shelter3 = Shelter.create!(name: 'Animal Haven', city: 'Fort Collins', foster_program: true, rank: 3)

# Pets
pet1 = Pet.create!(name: 'Doofus', breed: 'Mixed', age: 3, shelter: shelter1, adoptable: true)
pet2 = Pet.create!(name: 'Snoopy', breed: 'Beagle', age: 5, shelter: shelter1, adoptable: true)
pet3 = Pet.create!(name: 'Mark', breed: 'Tabby', age: 2, shelter: shelter2, adoptable: true)
pet4 = Pet.create!(name: 'Fluffy', breed: 'Persian', age: 4, shelter: shelter2, adoptable: true)
pet5 = Pet.create!(name: 'mr. fluff', breed: 'Poodle', age: 6, shelter: shelter3, adoptable: true)

# Adoptions
adoption1 = Adoption.create!(
  name: 'John Doe',
  street_address: '123 Main Street',
  city: 'Denver',
  state: 'CO',
  zip_code: '80202',
  description: 'I have a big backyard and love animals.',
  status: 'In Progress'
)

adoption2 = Adoption.create!(
  name: 'Jane Smith',
  street_address: '456 Elm Street',
  city: 'Boulder',
  state: 'CO',
  zip_code: '80301',
  description: 'I love pets and have a lot of free time.',
  status: 'In Progress'
)

adoption3 = Adoption.create!(
  name: 'Jack Black',
  street_address: '789 Oak Avenue',
  city: 'Fort Collins',
  state: 'CO',
  zip_code: '80521',
  description: 'I am an experienced pet owner.',
  status: 'Pending'
)

adoption4 = Adoption.create!(
  name: 'Jill White',
  street_address: '321 Pine Street',
  city: 'Loveland',
  state: 'CO',
  zip_code: '80538',
  description: 'I work from home and can take care of pets all day.',
  status: 'Pending'
)

# AdoptionPets
AdoptionPet.create!(adoption: adoption1, pet: pet1)
AdoptionPet.create!(adoption: adoption1, pet: pet2)
AdoptionPet.create!(adoption: adoption2, pet: pet1)
AdoptionPet.create!(adoption: adoption2, pet: pet3)
AdoptionPet.create!(adoption: adoption3, pet: pet4)
AdoptionPet.create!(adoption: adoption4, pet: pet5)

puts "Seeding completed successfully!"
