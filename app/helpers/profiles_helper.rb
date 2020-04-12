module ProfilesHelper
	def gravatar_for(user, options = { size: 50 })
		email_digest = Digest::MD5::hexdigest(user.email.strip.downcase)
		size = options[:size]
		gravatar = "https://www.gravatar.com/avatar/#{email_digest}?s=#{size}"
		image_tag(gravatar, alt: "#{user.l_name}_avatar", class: 'gravatar')
	end
end
