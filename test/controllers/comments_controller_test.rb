require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Warden::Test::Helpers
  Warden.test_mode!
  
  def setup
    @gram = grams(:gram_1)
  end
  
  test "should create a comment on a gram" do
    user = users(:justin)
    
    sign_in user
    
    assert_difference ['Comment.count', '@gram.comments.count', 'user.comments.count'], 1 do
      post :create, gram_id: @gram, comment: { message: 'awesome gram' }
    end
    
    assert_redirected_to root_path
    
    assert_equal 1, @gram.comments.count
    assert_equal 'awesome gram', @gram.comments.first.message
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference ['Comment.count', '@gram.comments.count'] do
      post :create, gram_id: @gram, comment: { message: 'awesome gram' }
    end
    
    assert_redirected_to new_user_session_path
  end

  test "should return 404 for create if gram not found" do
    user = users(:justin)
    sign_in user
    
    assert_no_difference 'Comment.count' do
      post :create, gram_id: 'TACOCAT', comment: { message: 'awesome gram' }
    end
    
    assert_response :not_found
  end

end