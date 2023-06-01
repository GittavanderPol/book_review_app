class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true

  scope :find_by_name, ->(query) do
    where("name LIKE ?", "%#{sanitize_sql_like(query)}%")
  end
end
