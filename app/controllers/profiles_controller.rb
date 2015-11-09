class ProfilesController < ApplicationController
  def index
    @user = current_user
  end
  
  def new
    if not current_user.profile.present?
      @user = current_user
      @profile = @user.build_profile
    else 
      redirect_to root_path(@user)
    end
  end
  
  def create
    @user = current_user
      @profile = @user.build_profile(profile_params)
      @profile.save
      redirect_to user_profile_path(@user,@profile)
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
      redirect_to user_profile_path(@user,@profile)
    else      
      render 'edit'
    end
  end
  
   private
    def profile_params
      params.require(:profile).permit(:sex, :tel, :address, :birthday, :avatar, :user_id)
    end
  
end
