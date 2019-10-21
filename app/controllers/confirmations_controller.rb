class ConfirmationsController < Devise::ConfirmationsController

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      redirect_to after_confirmation_path
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  protected

  # The path used after confirmation.
  def after_confirmation_path
    Rails.env.production? ? '//ttnote.cn/login?emailConfirmed' : '//beta.ttnote.cn/login?emailConfirmed'
  end
end