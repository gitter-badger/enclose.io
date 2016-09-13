class OmniauthController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    raise @user.errors.full_messages unless @user.persisted?
    sign_in_and_redirect @user, :event => :authentication
  end
end
