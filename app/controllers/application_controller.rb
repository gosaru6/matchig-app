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

  def user_email
    @conversation = Conversation.find(params[:conversation_id])
    @recipient_user = User.find_by(id: @conversation.recipient_id)
  end

  def posted_index
    @user_posted = Post.where(user_id: params[:id]).page(params[:page]).per(5)
  end

  def post_search
    @search_post = Post.page(params[:page]).per(10).where( 'title LIKE ?', "%#{params[:search]}")
    @search_user = User.page(params[:page]).where('name LIKE ?', "%#{params[:search]}%")
  end

  def forbid_login_user
    if current_user
      flash[:notice] = "すでにログインしています"
      redirect_to posts_path
    end
  end

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end

end
