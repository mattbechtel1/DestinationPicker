class Language < ApplicationRecord
    has_many :destinations, foreign_key: :language_primary_id
    has_many :destinations, foreign_key: :language_secondary_id
    validates :name, uniqueness: true
end
