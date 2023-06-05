require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "creates a book" do
    author = authors(:maine)
    assert_difference("Book.count", +1) do
      Book.create(title: "Same old", author_id: author.id)
    end
  end

  test "fails without title" do
    book = Book.new(title: "", author_id: 1)
    assert_not book.valid?
    assert "can't be blank", book.errors[:title]
  end
end
