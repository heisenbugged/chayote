require 'spec_helper'

describe ProjectsController do
  context "GET 'show'" do
    before(:each) do
      @user = Fabricate(:user)
      sign_in @user

      @project = Fabricate(:project)
      Fabricate(:member, :project => @project, :user => @user)
    end
    it "is successful"  do
      get :show, :id => @project.id
      response.should be_success
    end
    
    it "renders the show template" do
      get :show, :id => @project.id
      response.should render_template('show')
    end

    it "groups tasks by most recent entry date" do
      get :show, :id => @project.id
      assigns(:tasks).should_not be_nil
    end
  end
end
