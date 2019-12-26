class AddUserIdToTomato < ActiveRecord::Migration[5.2]
  def change
    add_reference :tomatoes, :user,  index: true, foreign_key: false, null: false
  end
end
