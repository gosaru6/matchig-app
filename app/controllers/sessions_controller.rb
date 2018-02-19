class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      current_user
      redirect_to posts_path(user.id)
    else
      flash[:notice] = "メールアドレスかパスワードが間違っています。"
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end
end
