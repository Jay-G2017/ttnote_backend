class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :desc
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: false, null: false

      t.timestamps
    end
  end
end
