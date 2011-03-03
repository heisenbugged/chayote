include ApplicationHelper
class Member
  include Mongoid::Document
  referenced_in :user
  referenced_in :project
  after_destroy :destroy_project_rate
  #field :rate
  private
  def destroy_project_rate
    @rate = member_project_rate(self)
    if @rate
      @rate.delete
    end
  end
end