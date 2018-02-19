class UsersController < ApplicationController
  before_action :forbid_login_user, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :current_user_check, {only: [:interpreter, :index, :show, :follow, :follower]}

  def index
    @users =
      if params[:search]
        #searchされた場合は、原文+.where('name LIKE ?', "%#{params[:search]}%")を実行
        User.page(params[:page]).where('name LIKE ?', "%#{params[:search]}%").per(12)
      else
        #searchされていない場合は、原文そのまま
        User.page(params[:page]).per(12)
      end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    posted_index
    @user = User.find(params[:id])
    @follow = @user.following.count
    @follower = @user.followers.count
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "退会処理を行いました"
  end

  def interpreter
    @interpreters =
    if params[:search]
      #searchされた場合は、原文+.where('name LIKE ?', "%#{params[:search]}%")を実行
      User.where(sort: 2).page(params[:page]).where('name LIKE ?', "%#{params[:search]}%").per(12)
    else
      #searchされていない場合は、原文そのまま
      User.where(sort: 2).page(params[:page]).per(12)
    end
  end

  def follow
    user = User.find(params[:id])
    @users =
    if params[:search]
      user.following.page(params[:page]).where('name LIKE ?', "%#{params[:search]}%").per(12)
    else
      user.following.page(params[:page]).per(12)
    end
  end

  def follower
    user = User.find(params[:id])
    @users =
    if params[:search]
      user.followers.page(params[:page]).where('name LIKE ?', "%#{params[:search]}%").per(12)
    else
      user.followers.page(params[:page]).per(12)
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmaiton,
                                   :gender, :age, :image, :sort, :experience)
    end
end
