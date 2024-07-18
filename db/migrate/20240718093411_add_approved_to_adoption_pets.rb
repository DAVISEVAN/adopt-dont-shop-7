class AddApprovedToAdoptionPets < ActiveRecord::Migration[7.1]
  def change
    add_column :adoption_pets, :approved, :boolean
  end
end
