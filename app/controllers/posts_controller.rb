class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :current_user_check, only: [:new, :edit, :show, :destroy]

  def index
    @posts =
      if params[:search]
        Post.page(params[:page]).per(10).where('title LIKE ?', "%#{params[:search]}").includes(:user)
      else
        #searchされていない場合は、原文そのまま
        Post.page(params[:page]).per(10).includes(:user)
      end

    @post = Post.new
    user_find if current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      redirect_to posts_path, notice: "投稿できませんでした"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "編集しました"
    else
      render :edit
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

end
