class AddBooksCountToAuthor < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :books_count, :integer, default: 0
  end
end
