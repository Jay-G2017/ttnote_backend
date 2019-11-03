class CreateTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.string :name
      t.references :project, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
