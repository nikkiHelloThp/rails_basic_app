class City < ApplicationRecord
	has_many :authors, dependent: :destroy
end
