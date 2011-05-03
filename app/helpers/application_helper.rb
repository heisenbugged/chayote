module ApplicationHelper
  def member_project_rate(member)
    member.user.rate_for(member.project)
  end
  def readable_date(date)
    (date) ? date.strftime("%d %B %Y") : "Not Available"
  end
  def date_time(model)
    readable_date(model.date)
  end
  def task_cost(hours,rate)
    hours*rate
  end
end
