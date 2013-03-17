class Project
  include Mongoid::Document
  
  field :name
  references_many :members, :dependent => :destroy
  references_many :tasks, :dependent => :destroy
  references_many :snapshots

  def users
    members.collect{ |member| member.user }
  end
  def has_user?(user)
    users = members.collect{ |member| member.user }
    users.include?(user)
  end
  #current logged on user tasks
  def user_tasks(user)
    tasks.where(:user_id => user.id)    
  end
  def tasks_for_dates(start_date, end_date)

  end
end