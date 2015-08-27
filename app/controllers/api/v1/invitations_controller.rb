module Api
	module V1
		class InvitationsController<ApplicationController
			skip_before_filter :verify_authenticity_token
			respond_to :json

			def create
				@invite_to = User.find_by(id: params[:invite][:to_user_id])
				params[:invitation][:user_id]=params[:invite][:current_user_id]
				#@inuser=params[:invitation][:inuser]
				params[:invitation][:invited_by]=params[:invite][:current_user_name]
				params[:invitation][:invited_mail]=params[:invite][:current_user_email]
				session=@opentok.create_session :media_mode=>:routed
				params[:invitation][:session_id]=session.session_id
				params[:invitation][:token]=@opentok.generate_token session.session_id
				@invite_to_id = @invite_to.id
				if @invite_to.invitations.exists?(:invited_mail =>params[:invite][:current_user_email])
					#@invite_to.invitations.find_by(:invited_mail =>current_user.email).destroy
					@invite_to.invitations.find_by(:invited_mail =>params[:invite][:current_user_email]).destroy
					@invitation = @invite_to.invitations.build(:invited_by=>params[:invitation][:invited_by],:invited_mail=>params[:invitation][:invited_mail],:session_id=>params[:invitation][:session_id],:token=>params[:invitation][:token])
				else
					@invitation = @invite_to.invitations.build(:invited_by=>params[:invitation][:invited_by],:invited_mail=>params[:invitation][:invited_mail],:session_id=>params[:invitation][:session_id],:token=>params[:invitation][:token])
				end

				respond_to do |format|
					@error = "invitation_failed"
					if @invitation.save
						@sessionId = params[:invitation][:session_id]
	  				@opentok_token = @opentok.generate_token @sessionId
	  				@room = {:session_id => @sessionId,:token=>@opentok_token}
						#render 'sessions/room'
						format.json {render json: @room, status: :invitation_sent}
					else
						format.json {render json: @error, status: :invitation_failed }
					end
				end

			end

			def destroy_session
			#	@session_id = params[:invite_to_mail]
				@all_users = User.all
				@error = "unsuccessful"
				@invite_to = User.find_by(:id => params[:session_destroy][:to_user_id])
				@edit_invitation = @invite_to.invitations.find_by(:invited_mail =>params[:session_destroy][:current_user_email]).destroy
				respond_to do |format|
					if @edit_invitation.save
						format.json {render json: @all_users, status: :session_destroyed}
					else
						format.json{render json: @error, status: :unsuccessful}
					end
				end
			end

		end
	end
end