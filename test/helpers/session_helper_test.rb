require "test_helper"

class SessionHelperTestController < ApplicationController
  include SessionsHelper

  def store_url
    store_redirect_url(:my_namespace)
    head :ok
  end

  def redirect_to_url
    redirect_back_or(:my_namespace, root_path)
  end
end

Rails.application.routes.disable_clear_and_finalize = true

Rails.application.routes.draw do
  get "store_url", to: "session_helper_test#store_url"
  post "store_url", to: "session_helper_test#store_url"
  get "redirect_to_url", to: "session_helper_test#redirect_to_url"
end

class SessionHelperTest < ActionController::TestCase
  setup do
    @controller = SessionHelperTestController.new
  end

  test "it puts the redirect url into the session" do
    get :store_url
    assert_equal "http://test.host/store_url", @controller.session.to_h["redirect_url_my_namespace"]
  end

  test "it does not store the redirect url in the session if it is not a GET request" do
    post :store_url
    assert_equal ({}), @controller.session.to_h
  end

  test "it uses the redirect url from the session" do
    get :store_url
    get :redirect_to_url
    assert_redirected_to "http://test.host/store_url"
  end

  test "it uses fallback url in case no redirect url is stored" do
    get :redirect_to_url
    assert_redirected_to root_path
  end
end
