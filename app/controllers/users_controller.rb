class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    if params[:city_name]
      city = City.where(:name => params[:city_name])
      
      @users = User.where("city_id = ?", city)
    else
      @users = User.all
    end
  end
  
  def new
  end
  
  def create
    if @user.save
      flash[:notice] = "Registration Successful."
      if current_user.try(:role) == 'admin'
        redirect_to users_path
      else
        redirect_to login_path
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      if current_user.try(:role) == 'admin'
        redirect_to users_path
      else
        redirect_to '/'+current_user.city.name.gsub(/ /,'')
      end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "Successfully removed user."
    redirect_to users_url
  end
end
