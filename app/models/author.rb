class Author < ApplicationRecord

	belongs_to :city, optional: true
	has_many :active_relationships, class_name: 	'Relationship',
																	 foreign_key: 'follower_id',
																	 dependent:   :destroy
	has_many :passive_relationships, class_name:  'Relationship',
																	 foreign_key: 'followed_id',
																	 dependent:   :destroy
	has_many :following, through: :active_relationships,  source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	has_many :gossips, 										dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :likes, 											dependent: :destroy
	has_many :sent_messages, 		 foreign_key: 'sender_id', 		class_name: "PrivateMessage"
	has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"

	attr_accessor :remember_token, :activation_token, :reset_token

	before_save 	:downcase_email
	before_create :create_activation_digest

	has_secure_password

	scope :active, -> { where(activated: true) }

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
		update_columns(activated: true, activated_at: Time.zone.now)
	end

	def send_activation_email
		AuthorMailer.account_activation(self).deliver_now
	end

	def create_password_reset_digest
		self.reset_token  = Author.new_token
		update_columns(reset_digest: 	Author.digest(reset_token),
									 reset_sent_at: Time.zone.now)
	end

	def send_password_reset_email
		AuthorMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	def feed
		following_ids_subselect = "SELECT followed_id FROM relationships
															 WHERE  follower_id = :user_id"
		Gossip.where("author_id IN (#{following_ids_subselect})
									OR author_id = :user_id", user_id: id)
	end

	def follow(other_author)
		active_relationships.create(followed_id: other_author.id)
	end

	def unfollow(other_author)
		active_relationships.find_by(followed_id: other_author.id).destroy
	end

	def following?(other_author)
		following.include?(other_author)
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