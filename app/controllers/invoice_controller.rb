class InvoiceController < ApplicationController
  before_filter :authenticate_user!

  def new
    authorize! :invoice, current_user
    @projects = Project.all
  end

  def show    
    authorize! :invoice, current_user

    if params[:start_date].class == Date
      @start_date = params[:start_date].to_time
    elsif params[:start_date].class == Time
      @start_date = params[:start_date]
    else
      @start_date = Time.parse(params[:start_date])
    end

    if params[:end_date].class == Date
      @end_date = params[:end_date].to_time
    elsif params[:end_date].class == Time
      @end_date = params[:end_date]      
    else
      @end_date = Time.parse(params[:end_date])
    end

    @project = Project.find(params[:project])
    @total_cost = 0
    @grouped_entries = {}
    time_entries = TimeEntry.where(:date.gte => @start_date, :date.lte => @end_date).collect {
                                   |entry| entry if entry.task.project == @project
                                   }.compact.group_by(&:task)
    
    time_entries.each do |task, entries|
        task_hours = 0
        user = task.user
        entries.each do |entry|
          task_hours += entry.hours
        end
        @grouped_entries[user.id] = InvoiceUserMapping.new(user, @project) if @grouped_entries[user.id].nil?
        @grouped_entries[user.id].add_task_mapping(task, task_hours)
        
        @total_cost += (task_hours*@grouped_entries[user.id].rate)
    end

    render :layout => 'barebones'
  end

  def snapshot
    binding.pry
  end
  
private
  def time_entries
    
  end

end
