class ProfilesController < ApplicationController
  def index
    @user = current_user
    if user_signed_in?
      if current_user.profile.present?
        @url = current_user.profile.avatar.url
        @path = user_profile_path(@user, @user.profile)
      else
        @url = "default.png"
        @path = new_user_profile_path(@user)
      end
    end
  end
  
  def new
    if not current_user.profile.present?
      @user = current_user
      @profile = @user.build_profile
    end
  end
  
  def create
    @user = current_user
      @profile = @user.build_profile(profile_params)
      if @profile.save
      redirect_to user_profile_path(@user, @profile)
      else
        render 'new'
      end
  end
  
  def show
    @user = current_user
    @profile = Profile.find(params[:id])
  end
  
  def edit
    @user = current_user
    @profile = Profile.find(params[:id])
  end

  def update
    @user = current_user
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)    
      redirect_to user_profile_path(@user, @profile)
    else      
      render 'edit'
    end
  end
  
   private
    def profile_params
      params.require(:profile).permit(:sex, :tel, :address, :birthday, :avatar, :user_id)
    end
  
end
