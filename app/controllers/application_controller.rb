class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def current_user_check
    current_user
    if !logged_in?
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end

  def user_find
    @user = User.find(current_user.id)
  end

  def authenticat_user

  end

  def posted_index
    @user_posted = Post.where(user_id: params[:id]).page(params[:page]).per(5)
  end

end
