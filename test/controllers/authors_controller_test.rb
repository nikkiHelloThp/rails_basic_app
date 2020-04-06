require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create
    assert_response :success

    author = Author.new(email: 'e@mail.com', password: '123456')
    assert author.save
  end

  test "should get destroy" do
    delete :destroy, params: {id: 1}
    assert_response :success
  end

end
