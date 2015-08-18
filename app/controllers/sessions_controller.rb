class SessionsController < ApplicationController
  
  def new
  end
  
  def create
  	#render 'new'
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user&&user.authenticate(params[:session][:password])
  		log_in user
     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_back_or user
  	else
  		flash[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end
 def room
  @opentok_token = @opentok.generate_token current_user.session_id
  @sessionId = current_user.session_id
  @count = current_user.invitations.count
  #@url ="http://localhost:3000/room/"+current_user.id.to_s
  #url=current_user.id.to_s

 end

 def chatroom
  @sessionId=params[:session_id]
  @opentok_token=@opentok.generate_token @sessionId 
  @chatuser = params[:someone]
 end

  def destroy
  	  log_out if logged_in?
  	redirect_to root_url
  end
 
end
