require 'test_helper'
require 'tb_api'
require 'grape'

class TbAPITest < ActionController::TestCase
  
  test "should signup successfully" do
    post '/api/user/signup', :email=>"zjueman@qq.com", :name=>"Ben", :password=>"test123"
    assert_response :success
    user = User.find_by_name "Ben"
    assert_not_nil user, "user should not be null but it is"
    assert_equal "zjueman@qq.com", user.email
  end

end
