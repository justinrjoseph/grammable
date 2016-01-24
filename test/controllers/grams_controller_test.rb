require 'test_helper'

class GramsControllerTest < ActionController::TestCase
  
  test "should get root" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create a gram" do
    get :new
    assert_template 'grams/new'
    
    assert_difference 'Gram.count', 1 do
      post :create, gram: { message: 'Hello!' }
    end

    assert_redirected_to root_path
    
    gram = Gram.last
    assert_equal 'Hello!', gram.message
  end
  
  test "should reject invalid grams" do
    assert_no_difference 'Gram.count' do
      post :create, gram: { message: '' }
    end

    assert_template 'grams/new'
    assert_response :unprocessable_entity
  end
  
end
