class ChangeUserSettingColumnTypeToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :user_settings, :tomato_minutes, :float
    change_column :user_settings, :short_rest_minutes, :float
    change_column :user_settings, :long_rest_minutes, :float
  end
end
