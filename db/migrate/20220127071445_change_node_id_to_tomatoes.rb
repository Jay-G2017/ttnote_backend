class ChangeNodeIdToTomatoes < ActiveRecord::Migration[5.2]
  def change
    change_column :tomatoes, :node_id, :string
  end
end
