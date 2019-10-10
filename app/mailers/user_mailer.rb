class UserMailer < Devise::Mailer
  default from: "蕃茄时光 <welcome@ttnote.cn>"
  default reply_to: "welcome@ttnote.cn"
  include Devise::Controllers::UrlHelpers

  def confirmation_instructions(record, token, opts={})
    opts[:subject] = "用户注册确认"
    super
  end

end