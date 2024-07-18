class AddRejectedToAdoptionPets < ActiveRecord::Migration[7.1]
  def change
    add_column :adoption_pets, :rejected, :boolean, default: false
  end
end
