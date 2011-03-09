module ApplicationHelper
  def member_project_rate(member)
    member.user.rate_for(member.project)
  end
  def date_time(model)
    model.date.strftime("%d %B %Y")
  end
  def task_cost(hours,rate)
    BigDecimal.new(hours.to_s)*BigDecimal(rate.to_s)
  end
end
