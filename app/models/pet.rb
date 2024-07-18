class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  
  
  belongs_to :shelter
  has_many :adoption_pets
  has_many :adoptions, through: :adoption_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_by_name(name)
    where("name ILIKE ?", "%#{name.downcase}%")
  end
end
