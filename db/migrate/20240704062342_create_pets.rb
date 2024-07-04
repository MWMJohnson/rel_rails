class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.boolean :special_needs
      t.integer :age
      t.references :shelter, null: false, foreign_key: true
      t.timestamps
    end
  end
end
