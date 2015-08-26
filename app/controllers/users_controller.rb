class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update,:index,:show,:destroy]
before_action :correct_user,   only: [:edit, :update,:show]
before_action :admin_user,     only: :destroy

  def index
     @users = User.paginate(page: params[:page])
     @invitation = Invitation.new
     #@invitations = Invitation.find_by(id:1)
  end

	def show
		@user = User.find(params[:id])
    @invitations = @user.invitations
    @knowUser=current_user.email
	end

  def new
  	@user = User.new

  end
  def create
    session = @opentok.create_session :media_mode => :routed
    #params[:user][:session_id] = session.session_id
  	@user = User.new(strong_params)
  	if @user.save
      log_in @user
      
      flash[:success]="welcome to the chatapp"
      redirect_to @user
  	else
  		render 'new'
  	end
  end
    def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(strong_params)
      flash[:success]="profile successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  	def strong_params
  			params.require(:user).permit(:name,:email,:password,:password_confirmation)
  	end
    def logged_in_user
      unless logged_in?
        store_location
      flash[:danger]="please log in"
      redirect_to root_url
    end
    end
       def correct_user
      @user = User.find(params[:id])
      redirect_to(users_url) unless current_user?(@user)
    end
     def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
