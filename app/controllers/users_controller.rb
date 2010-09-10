class UsersController < ApplicationController
  before_filter :require_user
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    user_hash = params[:user]
    password = user_hash[:password].to_s
    @user.password = password
    @user.course_id = user_hash[:course_id].to_i
    if @user.save
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    @user = User.find_by_id(params[:id].to_i)
    @user.destroy
    flash[:notice] = "Account removed."
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
