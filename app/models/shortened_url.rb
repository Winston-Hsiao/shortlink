class ShortenedUrl < ApplicationRecord
    validates :original_url, presence: true, length: { minimum: 24 }
    validates :short_url, presence: true, length: { maximum: 23 }
end
