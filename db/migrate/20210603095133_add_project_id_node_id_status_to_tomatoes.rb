class AddProjectIdNodeIdStatusToTomatoes < ActiveRecord::Migration[5.2]
  def change
    add_reference :tomatoes, :project,  index: true, foreign_key: false, null: false
    add_column :tomatoes, :node_id, :integer
    add_column :tomatoes, :status, :integer
  end
end
