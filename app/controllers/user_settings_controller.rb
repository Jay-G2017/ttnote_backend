class UserSettingsController < ApplicationController
  def update
    setting = current_user.user_setting
    setting.update!(user_setting_params)

    render json: setting
  end

  private
  def user_setting_params
    params.require(:user_setting).permit(
        :tomato_minutes,
        :short_rest_minutes,
        :long_rest_minutes,
        :auto_rest
        )
  end
end
