class Adoption < ApplicationRecord
    has_many :adoption_pets
    has_many :pets, through: :adoption_pets
  
    validates :name, presence: true
    validates :street_address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip_code, presence: true
    validates :description, presence: true
    validates :status, presence: true

    def approve_pet(pet_id)
      adoption_pet = adoption_pets.find_by(pet_id: pet_id)
      adoption_pet.update(approved: true) if adoption_pet
    end
  end
  