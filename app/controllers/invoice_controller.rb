class InvoiceController < ApplicationController
  before_filter :authenticate_user!

  def new
    authorize! :invoice, current_user
    @projects = Project.all
  end

  def show    
    authorize! :invoice, current_user
    @project = Project.find(params[:project])
    @total_cost = 0
    @grouped_entries = {}

    start_date   = Time.parse(params[:start_date])
    end_date     = Time.parse(params[:end_date])

    task_ids     = Task.where(project_id: @project.id).map(&:id)
    time_entries = TimeEntry.where(:date.gte => start_date, :date.lte => end_date)
                            .where(:task_id.in => task_ids)
                            .compact.group_by(&:task)
    
    time_entries.each do |task, entries|
      task_hours = 0
      user = task.user
      entries.each do |entry|
        task_hours += entry.hours
      end
      @grouped_entries[user.id] = InvoiceUserMapping.new(user, @project) if @grouped_entries[user.id].nil?
      @grouped_entries[user.id].add_task_mapping(task, task_hours)        
      @total_cost += (task_hours * @grouped_entries[user.id].rate)
    end

    Snapshot.create_from_invoice(@grouped_entries, start_date, end_date) if params[:snapshot]
    render :layout => 'barebones'
  end

end
