require 'spec_helper'
describe Member do
  it "destroys project rate on delete" do
    user = Fabricate(:user)
    project = Fabricate(:project)
    rate = Fabricate(:project_rate, :user => user, :project => project)
    lambda do
      member = Fabricate(:member, :user => user, :project => project)
      member_project_rate(member).should_not be_nil
      member.destroy
    end.should change(ProjectRate, :count).by(-1)
  end
end
