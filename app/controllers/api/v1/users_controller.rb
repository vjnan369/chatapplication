module Api
	module V1
		class UsersController<ApplicationController
			respond_to :json

			def index
				respond_with(User.all)
			end
			def create
				@user = User.new(strong_params)
				if @user.save
					format.json {render json: @user, status: :created}
				else
					format.json {render json: @user.errors, status: :unprocessable_entity}
				end
			end
			def new
				data = {"name": "api","email": "api@gmail.com","password": "asdfasdf","password_confirmation": "asdfasdf" }
				uri = URI("http://localhost:3000/users")
				http = Net::HTTP.new(uri.host,uri.port)
				http.use_ssl = true
				request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
				request.body = data.to_json
				response = http.request(request)
			end
		end
	end
end