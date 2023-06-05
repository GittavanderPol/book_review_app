require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  test "creates an author" do
    assert_difference("Author.count", +1) do
      Author.create(name: "New Author")
    end
  end

  test "fails without name" do
    author = Author.new(name: "")
    assert_not author.valid?
    assert "can't be blank", author.errors[:name]
  end

  test "removes associated books" do
    author = authors(:maine)
    book = author.books.first

    assert_not_equal 0, author.books.count
    author.destroy!
    assert_equal 0, author.books.count
    assert_not Book.exists?(book.id)
  end
end
