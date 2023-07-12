class CreateEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :entities do |t|
      t.string :name
      t.decimal :amount, precision: 10, scale: 2
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      
      t.timestamps
    end
  end
end
