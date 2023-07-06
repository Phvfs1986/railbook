# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    def facebook
      user = User.from_omniauth(request.env['omniauth.auth'])
      if user.persisted?
        flash[:notice] = 'Signed in!'
        sign_in_and_redirect user
      else
        session['devise.user_attributes'] = user.attributes
        redirect_to new_user_registration_url
      end
    end
  end
end
