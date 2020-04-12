require 'test_helper'

class AuthorSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup informations" do
    get new_author_path
    assert_no_difference "Author.count" do
	    post authors_path, params: { author: { name:       'Walter Sobchak',
                                             email: 		 'author@invalid',
	    														 					 password: 							'foo',
	    														 					 password_confirmation: 'bar'
	    														 				  }
	    														}
		end
    assert_template 'authors/new'
    assert_select "div#error_explanation" do
      assert_select "p", "The form contains 3 errors"
      assert_select "ul" do
        assert_select "li[1]", "Password confirmation doesn't match Password"
        assert_select "li[2]", "Email is invalid"
        assert_select "li[3]", "Password is too short (minimum is 6 characters)"
      end
    end
  end

  test "valid signup informations" do
  	get new_author_path
  	assert_difference "Author.count", 1 do
  		post authors_path, params: { author: { name:        'Duke Lebowski',
                                             email: 			'author@valid.com',
  																					 password: 							'foobar',
  																					 password_confirmation: 'foobar'
  																					}
  																}
  	end
  	follow_redirect!
  	assert_template 'profiles/show'
    assert flash[:success], "Account successfully created" 
  end
end
