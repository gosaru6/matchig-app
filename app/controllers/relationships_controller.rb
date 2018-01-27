class RelationshipsController < ApplicationController
  # before_action :current_user_check, only: [:create, :destroy]
  respond_to :js

  def create
    if logged_in?
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user)
      respond_with @user
    else
      respond_with @user
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end
end
