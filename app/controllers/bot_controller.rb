class BotController < ApplicationController
  def index
    unless params[:msg] == "reset"
      step = params[:step].to_i
      if step > 1
        email_s = params[:value1].slice(/([0-9a-z.+]+[0-9a-z]@[0-9a-z][0-9a-z.-]+[0-9a-z])/ix)
        user = User.where(:email => email_s).first
      end
      if step > 2
        project_s = params[:value2]
        project = Project.where(:name => project_s).first
      end
      if step == 1
        @text = "Hi, welcome to the Chayote Bot! Please enter your email to begin."
      elsif step == 2
        @text = "Enter a project:<br>" + user.projects.map {|project| project.name }.join("<br>")
      elsif step == 3
        @text = "You have tasks:<br>" + project.tasks.where(:user_id => user.id).map {|task| task.name }.join("<br>")
      elsif step >= 4

          arr = params[:msg].split(/\s*\|\s*/)
          task_s = arr[0]
          time_entry_s = arr[1]

          task = Task.where(:name => task_s, :user_id => user.id).first
          unless task
            task = Task.new
            task.user = user
            task.project = project
            task.name = task_s
            task.save!
          end

          time_entry = TimeEntry.new
          time_entry.hours = time_entry_s
          time_entry.user = user
          time_entry.task = task
          time_entry.save!

          @text = "Time entry successfully added : " + arr[0] + " : " + arr[1]
      else
        @text = "I haven't gotten this far yet.<reset>"
      end
    else
      @text = "Bot has been reset.<reset>"
    end
  end
end
