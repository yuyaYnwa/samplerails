require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test "index" do
    5.times {FactoryGirl.create(:article)}
    get :index
    assert_response :success
    assert_equal 5, assigns(:articles).count
  end
  test "show" do
    article = FactoryGirl.create(:article,expire_at:nil)
    #showアクションを呼び出す
    get :show,id:article
    assert_response :success
  end
end
