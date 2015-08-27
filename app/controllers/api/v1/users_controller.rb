module Api
	module V1
		class UsersController<ApplicationController
			skip_before_action :verify_authenticity_token
			respond_to :json

			def index
				respond_with(User.all)
			end
			def create
				@user = User.new(strong_params)
				respond_to do |format|
				if @user.save
					format.json {render json: @user, status: :created}
				else
					format.json {render json: @user.errors, status: :unprocessable_entity}
				end
			end
			end
			def new
				
			end
			def show
				@user = User.find(params[:id])
				@invitations = @user.invitations
				respond_with(:user_details=>@user,:invitation_details=>@invitations)
			end
			private
			def strong_params
				params.require(:user).permit(:name,:email,:password,:password_confirmation)
			end
		end
	end
end