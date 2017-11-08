class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :current_user_check, only: [:new, :edit, :show, :destroy]

  def top
    redirect_to posts_path
  end

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      render 'new'
    end
  end

  def show
    
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :requested_date, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def current_user_check
    current_user
    if !logged_in?
      redirect_to new_session_path, notice: "ログインして下さい"
    end
  end

end
