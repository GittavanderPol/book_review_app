require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get authors_path
    assert_select "h1", "Authors"
    assert_select "table > tbody > tr", count: Author.count
    assert_select "table > tbody > tr:nth-child(1) td", Author.first.name
  end

  test "should create new author" do
    new_author_name = "Some name"

    assert_difference("Author.count", +1) do
      post authors_path, params: { author: { name: new_author_name } }
    end
    assert_redirected_to authors_path
    new_author = Author.last
    assert_equal new_author_name, new_author.name
  end

  test "should return error message when creating an incorrect author" do
    assert_no_difference("Author.count") do
      post authors_path, params: { author: { name: "" } }
      assert_select "div.alert.alert-danger", "The form contains 1 error."
      assert_select "ul > li", "Name can't be blank"
    end
  end

  test "should show author" do
    author = authors(:first)
    get author_path(author)
    assert_select "h1", "Jake Olson"
  end

  test "should edit author" do
    author = authors(:first)
    get author_path(author)
    assert_select "h1", "Jake Olson"
    patch author_path, params: { author: { name: "Jane Olson" } }
    assert_redirected_to author_path(author)
    follow_redirect!
    assert_select "h1", "Jane Olson"
  end

  test "should destroy author" do
    author = authors(:first)

    assert_difference("Author.count", -1) do
      delete author_path(author)
    end

    assert_redirected_to authors_path
  end
end
