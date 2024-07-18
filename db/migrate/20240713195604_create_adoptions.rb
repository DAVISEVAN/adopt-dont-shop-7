class CreateAdoptions < ActiveRecord::Migration[7.1]
  def change
    create_table :adoptions do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
