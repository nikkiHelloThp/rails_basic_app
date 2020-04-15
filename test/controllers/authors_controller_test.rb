require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase

  test "should get show" do
    get :show, params: {id: Author.last.id}
    assert_response :success
  end

  test "should get create" do
    post(:create, params: { author: 
                            { name: 'Harry Potter', 
                              email: 'fake@mail.com', 
                              password: '123456'
                            }
                          })
    

    author = Author.new(name: 'Ron Wisley',email: 'fake1@mail.com', password: '123456')
    assert author.save
  end

  test "should get destroy" do
    delete :destroy, params: {id: 1}
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, params: {id:Author.last.id}
  #   assert_response :success
  # end

  # test "should update author" do
  #   patch :update, params: {id: Author.last.id}
  #   assert_response :success
  # end

end
