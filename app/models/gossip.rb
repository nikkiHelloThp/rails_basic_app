class Gossip < ApplicationRecord
	belongs_to :author
	default_scope -> { order(created_at: :desc) }
	has_one_attached :picture
	# has_many :comments, as: :commentable, dependent: :destroy
	# has_many :likes, 											dependent: :destroy
	# has_one  :tag

	validates :picture, content_type: { in: %w[image/gif image/png image/jpeg],
																			message: "only allows png, jpeg, gif, jpg"},
											size: 				{ less_than: 1.megabyte,
																			message: 	 "should be less that 1MB"}
	
	validates :author_id,
		presence: true

	# validates :title,
	# 	presence: true,
	# 	length: { in: 3..14 }

	validates :body,
		presence: true,
		length: { maximum: 140 }

	def picture_resize
		picture.variant(resize: "300x300")
	end
end
