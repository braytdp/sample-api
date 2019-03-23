class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :destroy ]
  
  def index
    users = User.active

    json_response(users)
  end
  
  def show
    json_response(@user)
  end

  def create
    user = User.create!(user_params)

    json_response(user, :created)
  end

  def identification
    user = User.find_by_identification(params[:identification])

    json_response(user)
  end

  def destroy
    @user.update_attribute(:active, false)

    head :no_content
  end

  private

  def set_user
    @user = User.active.find(params[:id])
  end

  def user_params
    params.permit(:name, :identification, active: true)
  end
end
