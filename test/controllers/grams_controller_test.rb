require 'test_helper'

class GramsControllerTest < ActionController::TestCase
  
  test "getting the root page" do
    get :index
    assert_response :success
  end
  
end
