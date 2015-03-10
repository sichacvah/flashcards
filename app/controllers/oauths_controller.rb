class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to(review_path,
                  notice: t(:login_from_provider, provider: provider))
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to(review_path,
                    notice: t(:login_from_provider, provider: provider))
      end
    end
  end

  private

  def auth_params
    params.permit(:oauth_verifier, :oauth_token, :provider)
  end
end
