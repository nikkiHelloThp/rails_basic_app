class Author < ApplicationRecord
	attr_accessor :remember_token

	before_save :case_insensitive

	has_secure_password

	belongs_to :city, optional: true

	has_many :gossips, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
	has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email,
		presence: true,
		length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
		
	validates :password,
		presence: true,
		length: { minimum: 6 }

	# validates :age,
	# 	presence: true

	# validates :description,
	# 	presence: true

	# validates :f_name,
	# 	presence: true
	
	# validates :l_name,
	# 	presence: true

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

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def full_name
		"#{f_name} #{l_name}"
	end


	private

	def case_insensitive
		self[:email] = email.downcase!
	end
end