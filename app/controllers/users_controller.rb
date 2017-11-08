class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    posted_index
    @user = User.find(params[:id])
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
    redirect_to posts_path, notice: "退会処理を行いました"
  end

  def interpreter
    @interpreters = User.where(sort: 2)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmaiton,
                                   :gender, :age, :image, :sort, :experience)

    end

end
