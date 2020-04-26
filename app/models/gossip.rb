class Gossip < ApplicationRecord
	belongs_to :author
	default_scope -> { order(created_at: :desc) }
	# has_many :comments, as: :commentable, dependent: :destroy
	# has_many :likes, 											dependent: :destroy
	# has_one  :tag
	
	validates :author_id,
		presence: true

	# validates :title,
	# 	presence: true,
	# 	length: { in: 3..14 }

	validates :body,
		presence: true,
		length: { maximum: 140 }
end
