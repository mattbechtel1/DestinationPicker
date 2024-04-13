class Flag < ApplicationRecord
    has_many :destinations, foreign_key: :flag_primary_id

    def get_flag_emoji
        chars = self.code.split('').map {|char| char.ord + 127397 }
        "&\##{chars[0]};&\##{chars[1]};".html_safe
    end
end
