module ProfilesHelper
	def gravatar_for(user)
		email_digest = Digest::MD5::hexdigest(user.email.strip.downcase)
		gravatar = "https://www.gravatar.com/avatar/#{email_digest}"
		image_tag(gravatar, alt: "#{user.l_name}_avatar", class: 'gravatar')
	end
end
