require 'test_helper'

class AuthorsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin     = authors(:one)
  	@non_admin = authors(:two)
  end

  test "index as admin including pagination and delete links" do
  	log_in_as(@admin)
  	get authors_path
  	assert_template "authors/index"
  	assert_select "div .digg_pagination"
  	Author.paginate(page: 1).each do |author|
  		assert_select "a[href=?]", author_path(author), text: author.name
      unless @admin == author
      assert_select "a[href=?]", author_path(author), text: "delete",
                                                      method: :delete
  	  end
    end
    assert_difference "Author.count", -1 do
      delete author_path(@non_admin)
    end
    # page count == (all records/ per page.to_f).ceil
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get authors_path
    assert_select "a", text: "delete", count: 0
  end
end
