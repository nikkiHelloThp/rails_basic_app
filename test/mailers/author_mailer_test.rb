require 'test_helper'

class AuthorMailerTest < ActionMailer::TestCase

  test "account_activation" do
    author = authors(:one)
    author.activation_token = Author.new_token
    mail = AuthorMailer.account_activation(author)
    assert_equal "Account activation", mail.subject
    assert_equal [author.email],          mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match author.name,              mail.body.encoded
    assert_match author.activation_token,  mail.body.encoded
    assert_match CGI.escape(author.email), mail.body.encoded
  end

  test "password_reset" do
    author = authors(:one)
    author.reset_token = Author.new_token
    mail = AuthorMailer.password_reset(author)
    assert_equal "Password reset", mail.subject
    assert_equal [author.email],          mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match author.reset_token,       mail.body.encoded
    assert_match CGI.escape(author.email), mail.body.encoded
  end

end
