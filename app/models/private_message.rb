class PrivateMessage < ApplicationRecord
	belongs_to :conversation
	belongs_to :author

	validates_presence_of :body, :conversation_id, :author_id

	def message_time
		created_at.strftime("%d/%m/%y at %H:%M")
	end
end
