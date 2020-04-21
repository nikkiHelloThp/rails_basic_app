class Author < ApplicationRecord
	attr_accessor :remember_token, :activation_token

	before_save 	:downcase_email
	before_create :create_activation_digest

	has_secure_password

	belongs_to :city, optional: true

	has_many :gossips, 										dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :likes, 											dependent: :destroy
	has_many :sent_messages, 		 foreign_key: 'sender_id', 		class_name: "PrivateMessage"
	has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"

	VALID_NAME_REGEX = /\A[a-zA-Z .,'-]+\z/

	validates :name,
		presence: true,
		length: { minimum: 6 },
		format: { with: VALID_NAME_REGEX }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email,
		presence: true,
		length: 		{ maximum: 255 },
		format: 		{ with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
		
	validates :password,
		presence: true,
		length: { minimum: 6 },
		on: :create # or, allow_blank: true

	class << self
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																										BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end

		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	def remember
		self.remember_token = Author.new_token
		update_attribute(:remember_digest, Author.digest(remember_token))
	end

	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def activate
		update_attribute(:activated, 	 true)
		update_attribute(:activated_at, Time.zone.now)
	end

	def send_activation_email
		AuthorMailer.account_activation(self).deliver_now
	end

	private

		def downcase_email
			email.downcase!
		end

		def create_activation_digest
			self.activation_token  = Author.new_token
			self.activation_digest = Author.digest(activation_token)
		end
end