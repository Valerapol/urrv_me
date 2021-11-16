class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    if params[:set_locale]
      redirect_to users_url(locale: params[:set_locale])
    else
      @users = User.all.order(created_at: :desc)
    end
  end

  def show
    if params[:set_locale]
      redirect_to user_url(locale: params[:set_locale])
    else
      @user = User.friendly.find(params[:id])
    end
  end

  def edit
    if params[:set_locale]
      redirect_to user_url(locale: params[:set_locale])
    else
      @user = User.friendly.find(params[:id])
      #authorize @user
    end
  end

  def update
    #authorize @user
    if @user.update(user_params)
      redirect_to users_path, notice: "#{I18n.t(:user_update)}"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
  def user_params
    params.require(:user).permit({role_ids: []})
  end
end