require 'spec_helper'

describe InvoiceController do
  context "GET 'new'" do
    describe "admin" do
      before(:each) do
        @user = Fabricate(:admin)
        sign_in @user
      end
      it "is successful" do
        get :new
        response.should be_success
      end
      it "loads all projects" do
        get :new
        11.times do
          project = Fabricate(:project)
          Fabricate(:member, :project => project, :user => @user)
        end
        assigns(:projects).count.should == 11
      end
    end
    describe "regular user" do
      before(:each) do
        @user = Fabricate(:user)
        sign_in @user
      end
      it "redirects to root url if not logged in" do
        get :new
        response.should redirect_to root_url
      end
    end
  end
  context "POST 'show'" do
    describe "admin" do
      before(:each) do
        @user = Fabricate(:admin)
        sign_in @user

        @project = Fabricate(:project)
        Fabricate(:member, :project => @project, :user => @user)
        Fabricate(:project_rate, :project => @project, :user => @user)
        
      end

      context "with valid parameters" do
        it "accepts time objects" do
          @attr = {:start_date => Time.now.beginning_of_week,
                  :end_date => Time.now.end_of_week,
                  :project => @project.id}

          post :show, @attr
          response.should be_success
        end
        it "accepts date objects" do
          @attr = {:start_date => Time.now.beginning_of_week.to_date,
                  :end_date => Time.now.end_of_week.to_date,
                  :project => @project.id}

          post :show, @attr
          response.should be_success
        end
        it "accepts date strings in '%Y-%m-%d' format" do
          @attr = {:start_date => Time.now.beginning_of_week.strftime('%Y-%m-%d'),
                  :end_date => Time.now.end_of_week.strftime('%Y-%m-%d'),
                  :project => @project.id}

          post :show, @attr
          response.should be_success
        end

        it "sets total cost for hours worked based on dates passed in" do          
          total_cost = 0
          10.times do
            task = Fabricate(:task, :project => @project, :user => @user)
            5.times do
              time_entry = Fabricate(:time_entry, :task => task)
              time_entry.hours.should <= 5
              total_cost += time_entry.hours * @user.rate_for(@project).amount
            end
          end
          @attr = {:start_date => Time.now.beginning_of_week,
                  :end_date => Time.now.end_of_week,
                  :project => @project.id}
          post :show, @attr
          assigns(:total_cost).should == total_cost
        end

      end

      context "with invalid parameters" do

      end
    end
  end
end
