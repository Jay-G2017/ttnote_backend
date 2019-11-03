class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
