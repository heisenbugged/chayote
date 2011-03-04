class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :show, Task, :user_id => user.id        
      can :manage, TimeEntry, :user_id => user.id
      can :show, Project do |project|
        project.has_user?(user)        
      end
      can :manage, :all if user.admin?
    end
  end
end
