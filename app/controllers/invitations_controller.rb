class InvitationsController < ApplicationController
	def new
		#@invitation = Invitation.new(name: "hello",user_id: 2,email: "hai@hai.com",session_id: "sdfddsf",token: "sdfsew")

	end
	def index
	end

	def create
		@invite_to = User.find_by(id: params[:invitation][:user_id])
		params[:invitation][:user_id]=current_user.id
		@inuser=params[:invitation][:inuser]
		params[:invitation][:invited_by]=current_user.name
		params[:invitation][:invited_mail]=current_user.email
		params[:invitation][:session_id]=current_user.session_id
		params[:invitation][:token]=@opentok.generate_token current_user.session_id
		#@invitation = current_user.invitations.create(invitation_params)
		#@usering = users(:jnan)
	#	@invitation=nil
		#people = {:invited_by=>params[:invitation][:invited_by],:invited_mail=>params[:invitation][:invited_mail],:session_id=>params[:invitation][:session_id],:token=>params[:invitation][:token]}
		if @invite_to.invitations.exists?(:invited_mail=>current_user.email)
			@invite_to.invitations.find_by(:invited_mail =>current_user.email).destroy
			@invitation = @invite_to.invitations.build(:invited_by=>params[:invitation][:invited_by],:invited_mail=>params[:invitation][:invited_mail],:session_id=>params[:invitation][:session_id],:token=>params[:invitation][:token])
		else
			
			@invitation = @invite_to.invitations.build(:user_id=>params[:invitation][:user_id],:invited_by=>params[:invitation][:invited_by],:invited_mail=>params[:invitation][:invited_mail],:session_id=>params[:invitation][:session_id],:token=>params[:invitation][:token])
		end
		if @invitation.save
			@opentok_token = @opentok.generate_token current_user.session_id
  @sessionId = current_user.session_id
			#flash[:success]="invitation sent successfully"
			render 'sessions/room'
		end
	end

	private
		def invitation_params
			params.require(:invitation).permit(:invited_by,:invited_mail,:session_id,:token)
		end
end
