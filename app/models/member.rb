include ApplicationHelper
# Association table for the many-to-many relationship between users and projects.
class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  referenced_in :user
  referenced_in :project
  after_destroy :destroy_project_rate

  private
  # Project rates are created alongside members (inside the MembersController create action).
  # When a member is destroyed, the project rate needs to be destroyed as well.
  def destroy_project_rate
    if user
      @rate = member_project_rate(self)
      if @rate
        @rate.delete
      end
    end
  end
end