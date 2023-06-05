class Book < ApplicationRecord
  belongs_to :author, counter_cache: true
  validates :title, presence: true

  scope :find_by_title, ->(query) do
    where("title LIKE ?", "%#{sanitize_sql_like(query)}%")
  end
end
