class PopulateAuthorBooksCount < ActiveRecord::Migration[7.0]
  def change
    Author.find_each do |author|
      Author.reset_counters(author.id, :books)
    end
  end
end
