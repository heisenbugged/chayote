require 'spec_helper'

describe HomeController do
  it "should redirect to sign in page if not logged in" do
    get :index
    response.should redirect_to new_user_session_path
  end
  it "should not redirect to sign in page if logged in" do
    @user = Fabricate(:user)
    sign_in @user
    get :index
    response.should render_template('index')
  end
  it "should retrieve the users projects" do
    @user = Fabricate(:user)
    sign_in @user
    @project = Fabricate(:project)
    Fabricate(:member, :project => @project, :user => @user)        
    get :index
    assigns(:projects).should_not be_nil
    assigns(:projects).count.should == 1
  end
end
