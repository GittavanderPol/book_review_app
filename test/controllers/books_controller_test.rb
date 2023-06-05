require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = authors(:maine)
  end

  test "should get book index" do
    get books_path
    assert_select "h1", "Books"
    assert_select "table > tbody > tr", count: Book.count
    assert_select "table > tbody > tr:nth-child(1) td", Book.first.title
  end

  test "should create a new book" do
    new_book_title = "Some book"

    assert_difference("Book.count", +1) do
      post books_path, params: { book: { title: new_book_title, author_id: @author.id } }
    end
    assert_redirected_to books_path
    new_book = Book.last
    assert_equal new_book_title, new_book.title
  end

  test "should use redirect path from session" do
    get author_path(@author)
    post books_path, params: { book: { title: "Some book", author_id: @author.id } }
    assert_redirected_to author_path(@author)
  end

  test "should return error message when creating a false book" do
    assert_no_difference("Book.count") do
      post books_path, params: { book: { title: "", author_id: @author.id } }
      assert_select "div.alert.alert-danger", "The form contains 1 error."
      assert_select "ul > li", "Title can't be blank"
    end
  end

  test "should show a single book page" do
    @book = books(:the_new_world)
    get book_path(@book)
    assert_select "h1", @book.title
    assert_select "h2", @book.author.name
  end

  test "should edit book" do
    @book = books(:the_new_world)
    get book_path(@book)
    assert_select "h1", "The new world"
    patch book_path, params: { book: { title: "A whole new land" } }
    assert_redirected_to book_path(@book)
    follow_redirect!
    assert_select "h1", "A whole new land"
  end

  test "should destroy a book" do
    @book = books(:the_new_world)
    assert_difference("Book.count", -1) do
      delete book_path(@book)
      assert_not Book.exists?(@book.id)
    end
    assert_redirected_to books_path
  end
end
