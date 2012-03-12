$:.unshift(File.dirname(__FILE__))

require 'helpers/test_helper'
require 'controllers/userstamp_controller'
require 'controllers/users_controller'
require 'controllers/posts_controller'
require 'models/user'
require 'models/person'
require 'models/post'
require 'models/comment'

class PostsControllerTest < ActionController::TestCase
  fixtures :users, :people, :posts, :comments

  def setup
    @routes = ActionDispatch::Routing::RouteSet.new
    @routes.draw do 
      resources :posts
    end
    
    @controller   = PostsController.new
    @request      = ActionController::TestRequest.new
    @response     = ActionController::TestResponse.new
    
    @post = Post.create!(:title => 'A post')
  end

  def test_update_post
    @request.session  = {:person_id => 1}
    put :update, :id => @post.id, :post => {:title => 'Different'}
    assert_response :success
    assert_equal    'Different', assigns["post"].title
    assert_equal    @delynn, assigns["post"].updater
    
    @post.reload
    assert_equal @delynn, @post.updater
  end

end

class UsersControllerTest < ActionController::TestCase
  fixtures :users, :people, :posts, :comments

  def setup    
    @routes = ActionDispatch::Routing::RouteSet.new
    @routes.draw do 
      resources :users
    end
    
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    
    @user = User.create!(:name => 'A user')
  end

  def test_update_user
    @request.session  = {:user_id => 2}
    put :update, :id => @user.id, :user => {:name => 'Different'}
    assert_response :success
    assert_equal    'Different', assigns["user"].name
    assert_equal    @hera, assigns["user"].updater
    
    @user.reload
    assert_equal @hera, @user.updater
  end
  
end