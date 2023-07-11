# frozen_string_literal: true

class CreateEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :entities do |t|
      t.string :name
      t.decimal :amount
      t.references :author, foreign_key: { to_table: :users }
      t.references :group, foreign_key: true
      t.timestamps
    end
  end
end
