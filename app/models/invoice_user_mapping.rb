class InvoiceUserMapping
  attr_accessor :user, :tasks, :total, :rate
  def initialize(user, project)
    @user = user
    @tasks = []
    @total = 0  
    @rate = user.rate_for(project).amount
  end
  def add_task_mapping(task,total)
    task_mapping = InvoiceTaskMapping.new
    task_mapping.task = task
    task_mapping.total = total
    @tasks.push(task_mapping)
  end
  def total_hours
    total = 0  
    tasks.each do |task_mapping|
      total += task_mapping.total
    end 
    total
  end
end