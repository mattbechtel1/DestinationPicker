class Region < ApplicationRecord
    validates :name, uniqueness: true
end
