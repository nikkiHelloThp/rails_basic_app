class Tag < ApplicationRecord
	belongs_to :gossip, optional: true
end
