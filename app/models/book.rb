class Book < ApplicationRecord
  belongs_to :author, counter_cache: true
  validates :title, presence: true
end
