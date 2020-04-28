class Gossip < ApplicationRecord
	belongs_to :author
	default_scope -> { order(created_at: :desc) }
	has_one_attached :picture
	# has_many :comments, as: :commentable, dependent: :destroy
	# has_many :likes, 											dependent: :destroy
	# has_one  :tag

	# VALID_PICTURE_REGEX = %r{/\.(png|jpeg|gif|jpg)$/}i
	# validates :picture, format: { with: VALID_PICTURE_REGEX, message: "only allows png, jpeg, gif, jpg" }
	# validates :picture, content_type: %w[image/gif image/png image/jpeg]

	# validates :picture, content_type: { in: %w[image/gif image/png image/jpeg],
	# 																		message: "only allows png, jpeg, gif, jpg"},
	# 										size: 				{ less_than: 1.megabyte,
	# 																		message: 	 "should be less that 1MB"}
	
	validates :author_id,
		presence: true

	# validates :title,
	# 	presence: true,
	# 	length: { in: 3..14 }

	validates :body,
		presence: true,
		length: { maximum: 140 }


	private

		def picture_type
			unless picture.content_type.in?(%w[image/gif image/png image/jpeg])
				errors.add(:picture, "only allows png, jpeg, gif, jpg")
			end
		end

		def picture_size
			if picture.byte_size > 1.megabyte
				errors.add(:picture, "should be less than 1MB")
			end
		end
end
