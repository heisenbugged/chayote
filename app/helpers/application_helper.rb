module ApplicationHelper
  def member_project_rate(member)
    member.user.rate_for(member.project)
  end
  def date_time(model)
    model.date.strftime("%d %B %Y")
  end
  def task_cost(hours,rate)
    number_to_currency(hours.to_i*rate.to_i)
  end
end
