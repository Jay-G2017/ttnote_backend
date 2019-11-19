class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :name, limit: 191
      t.boolean :done, default: false

      t.references :title, index: true, null: false
      t.references :project, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
