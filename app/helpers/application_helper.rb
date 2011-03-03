module ApplicationHelper
  def member_project_rate(member)
    member.user.rate_for(member.project)
  end
  def created_at_time(model)
    model.created_at.strftime("%d %B %Y")
  end
end
