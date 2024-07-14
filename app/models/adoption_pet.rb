class AdoptionPet < ApplicationRecord
  belongs_to :adoption
  belongs_to :pet
end
