class Gossip < ApplicationRecord
	belongs_to :author
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_one :tag
	
	validates :title,
		presence: true,
		length: { in: 3..14 }

	validates :body,
		presence: true
end
