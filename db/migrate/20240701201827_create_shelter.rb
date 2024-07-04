class CreateShelter < ActiveRecord::Migration[7.0]
  def change
    create_table :shelters do |t|
      t.string :name
      t.boolean :non_profit
      t.integer :rank
      

      t.timestamps
    end
  end
end
