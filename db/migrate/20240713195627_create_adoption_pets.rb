class CreateAdoptionPets < ActiveRecord::Migration[7.1]
  def change
    create_table :adoption_pets do |t|
      t.references :adoption, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
