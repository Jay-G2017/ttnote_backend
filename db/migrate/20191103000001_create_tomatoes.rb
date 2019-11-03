class CreateTomatoes < ActiveRecord::Migration[5.2]
  def change
    create_table :tomatoes do |t|
      t.integer :minutes
      t.text :desc

      t.references :todo, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
