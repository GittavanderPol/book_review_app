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
end
