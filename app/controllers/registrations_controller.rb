  class RegistrationsController < Devise::RegistrationsController
    # before_action :configure_sign_up_params, only: [:create]

    protected

    def after_sign_up_path_for(resource)
      Rails.env.production? ? 'ttnote.cn/login?emailConfirmed' : 'beta.ttnote.cn/login?emailConfirmed'
    end

    # # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [])
    # end
  end
