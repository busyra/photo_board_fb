class SessionsController < ApplicationController
	

	def new
		
	end

def show
    redirect_to root_path unless session['auth']
    @auth = session['auth']
end


	def create
		
		user = User.find_by(email: params[:login][:email])

		if user && user.authenticate(params[:login][:password])
			session[:user_id] = user.id.to_s
			redirect_to root_path 
			# notice: "Successfully logged in!"
		else
			render :new
		end

	end

	def facebook
		    @auth = request.env['omniauth.auth']
    session['auth'] = @auth
    redirect_to sessions_show_path


		# auth = request.env['omniauth.auth']
		# session[:omniauth] = auth.except('extra')
		# user = User.find_by_provider_and_uid(auth['provider'],auth['uid'])
		# #user = User.sign_in_from_omniauth(auth)
		# session[:user_id] = user.uid.to_s
  #   	redirect_to root_path
	end

	def destroy
		session.delete(:user_id)
		redirect_to sessions_show_path
	end
	def fbdestroy
    session['auth'] = nil
    redirect_to root_path
end
end