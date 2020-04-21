require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase

  def setup
    @user       = authors(:one)
    @other_user = authors(:two)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to new_session_url
  end

  test "should get show" do
    get :show, params: { id: @user }
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, params: { 
                    author: {
                      name:     'Harry Potter', 
                      email:    'fake@mail.com', 
                      password: '123456',
                    }
                  }

    author = Author.new(
               name:     'Ron Wisley',
               email:    'fake1@mail.com',
               password: '123456'
             )
    assert author.save
  end

  test "should redirect edit when not logged in" do
    get :edit, params: { id: @user }
    assert_not flash.empty?
    assert_redirected_to new_session_url
  end

  test "should redirect update when not logged in" do
    patch :update, params: { id: @user,
                             author: { 
                               email:    @user.email,
                               password: @user.password,
                             }
                           }
    assert_not flash.empty?
    assert_redirected_to new_session_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, params: { id: @user }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, params: { id: @user,
                             author: {
                               email:    @user.email,
                               password: @user.password,
                             }
                           }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, params: { id: @other_user,
                             author: {
                               name: 'Rick Sanchez',
                               email: 'rick@morty.com',
                               password: 'password',
                               password_confirmation: 'password',
                               admin: true,
                             }
                           }
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Author.count" do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to new_session_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference "Author.count" do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to root_url
  end

  test "should get destroy" do
    log_in_as(@user)
    delete :destroy, params: { id: @other_user }
    assert_not flash.empty?
    assert_redirected_to authors_url
  end
end
