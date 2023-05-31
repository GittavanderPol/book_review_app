class Book < ApplicationRecord
  belongs_to :author, counter_cache: true
end
