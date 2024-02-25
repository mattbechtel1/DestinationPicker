class Destination < ApplicationRecord
  belongs_to :language_1
  belongs_to :language_2
  belongs_to :flag_1
  belongs_to :flag_2
  belongs_to :region
end
