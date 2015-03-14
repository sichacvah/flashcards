class Dashboard::SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(session_params[:email], session_params[:password])
      redirect_to review_path, notice: "Вход выполнен!"
    else
      flash.now[:alert] = "Вход не удался"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: "Выход выполнен!"
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
