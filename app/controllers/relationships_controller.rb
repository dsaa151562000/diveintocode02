class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find(params[:relationships][:flollowed_id])
    current_user.followe!(@user)
    respond_wiht @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unflollow!(@user)
    respond_wiht @user
  end
end
