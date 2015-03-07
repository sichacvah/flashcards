class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    if current_user
      redirect_to review_path
    end
  end
end
