class Destination < ApplicationRecord
  belongs_to :language_primary, class_name: :Language
  belongs_to :language_secondary, class_name: :Language, optional: true
  belongs_to :flag_primary, class_name: :Flag, foreign_key: :flag_primary_id
  belongs_to :flag_secondary, class_name: :Flag, foreign_key: :flag_secondary_id, optional: true
  belongs_to :region
  accepts_nested_attributes_for :language_primary, :language_secondary, :region


  def flags
    if self.flag_secondary
      [self.flag_primary, self.flag_secondary]
    else
      [self.flag_primary, self.flag_primary]
    end
  end

  def languages
    if self.language_secondary
      [self.language_primary, self.language_secondary]
    else
      [self.language_primary]
    end
  end

  def self.select_random
    self.find(self.pluck(:id).sample)
  end

  def cities
    self.city.split('/')
  end

end
