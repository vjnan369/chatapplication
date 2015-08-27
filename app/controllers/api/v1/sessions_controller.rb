module Api
	module V1
		class SessionsController<ApplicationController
			skip_before_filter :verify_authenticity_token
			respond_to :json

			def create
				user = User.find_by(email: params[:session][:email].downcase)
				@errors = "login_unsuccessful"
				respond_to do |format|
		  		if user&&user.authenticate(params[:session][:password])
  					format.json {render json: user,status: :logged_in}	
     		#params[:session][:remember_me] == '1' ? remember(user) : forget(user)
     			else
     				format.json {render json: @errors, status: :unsuccessful_login}
     			end
     		end
			end
				
		end
	end
end