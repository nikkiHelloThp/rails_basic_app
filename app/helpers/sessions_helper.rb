module SessionsHelper

	# log the user in if the information provided
		# in the log in form are valid
	def log_in(user)
		session[:user_id] = user.id
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def current_user
		if (user_id = session[:user_id]) # here user_id is assigned '=' not compared '=='
			@current_user ||= Author.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = Author.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def current_user?(user)
		current_user == user
	end

	def logged_in?
		!current_user.nil? # or !!current_user
	end

	def forget(user) # opposite of remember(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def log_out
		forget current_user
		session.delete(:user_id)
		@current_user = nil
	end

	# redirects to stored location or default location
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	# store the url trying to be accessed
	def store_location
		session[:forwarding_url] = request.url if request.get?
	end
end
