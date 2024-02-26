class Flag < ApplicationRecord
    has_many :destinations, foreign_key: :flag_primary_id
end
