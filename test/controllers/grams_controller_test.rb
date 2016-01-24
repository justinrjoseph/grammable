require 'test_helper'

class GramsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include Warden::Test::Helpers
  Warden.test_mode!
  
  test "should get root" do
    get :index
    assert_response :success
  end
  
  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to new_user_session_path
  end
  
  test "should get new" do
    sign_in users(:justin)
    get :new
    assert_response :success
  end
  
  test "should redirect create when not logged in" do
    post :create, gram: { message: 'Hello!' }
    assert_redirected_to new_user_session_path
  end
  
  test "should create a gram" do
    user = users(:justin)
    
    sign_in user
    
    get :new
    assert_template 'grams/new'
    
    assert_difference 'Gram.count', 1 do
      post :create, gram: { message: 'Hello!' }
    end

    assert_redirected_to root_path
    
    gram = Gram.last
    assert_equal 'Hello!', gram.message
    assert_equal user, gram.user
  end
  
  test "should show gram if found" do
    gram = grams(:gram_1)
    get :show, id: gram
    assert_response :success
    assert_template 'grams/show'
  end
  
  test "should return 404 for show if gram not found" do
    get :show, id: 'TACOCAT'
    assert_response :not_found
  end
  
  test "should show edit if gram found" do
    gram = grams(:gram_1)
    get :edit, id: gram
    assert_response :success
    assert_template 'grams/edit'
  end
  
  test "should return 404 for edit if gram not found" do
    get :edit, id: 'TACOCAT'
    assert_response :not_found
  end
  
  test "should update a gram" do
    gram = grams(:gram_1)
    
    patch :update, id: gram, gram: { message: 'Changed' }
    
    assert_redirected_to root_path
    gram.reload
    assert_equal 'Changed', gram.message
  end
  
  test "should return 404 for update if gram not found" do
    patch :update, id: 'TACOCAT', gram: { message: 'Changed' }
    assert_response :not_found
  end
  
  test "should render edit for invalid update" do
    gram = grams(:gram_1)
    
    patch :update, id: gram, gram: { message: '' }
    assert_template 'grams/edit'
    assert_response :unprocessable_entity
    
    gram.reload
    assert_equal 'Hello', gram.message
  end
  
  test "should reject invalid grams" do
    sign_in users(:justin)
    
    assert_no_difference 'Gram.count' do
      post :create, gram: { message: '' }
    end

    assert_template 'grams/new'
    assert_response :unprocessable_entity
  end
  
end
