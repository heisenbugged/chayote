class Invoice
  include Mongoid::Document
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :number, :type => Integer
  referenced_in :project
  references_many :rates, :class => InvoiceRate, :dependent => :destroy

  validates_presence_of :start_date, :end_date
  validates_numericality_of :number, :only_integer => true
  
  before_validation :get_next_number
  before_create :create_invoice_rates

  def rate_for(user)
    rates.where(:user_id => user.id).first
  end
  def users
    rates.collect {|rate| rate.user}
  end
  def tasks_for_user(user)
    tasks.collect { |task| task if task.user == user }.compact
  end
  def total_hours_for_task(task)
    total_hours = 0
    time_entries_for_task(task).collect { |time_entry| total_hours += time_entry.hours}
    total_hours
  end
  def time_entries_for_task(task)
    time_entries.collect { |time_entry| time_entry if time_entry.task == task}.compact
  end
  def tasks
    time_entries.collect { |time_entry| time_entry.task }.uniq
  end
  def time_entries
    project.tasks.collect{ |task| task.time_entries.where(:date.gte => start_date, :date.lte => end_date).to_a }.flatten
  end
  private
  def create_invoice_rates
    project.users.collect { |user| InvoiceRate.create!(:user => user, :invoice => self, :amount => user.rate_for(project).amount ) }
  end
  def get_next_number
    if project && number.blank?
      last_invoice_number = Invoice.where(:project_id => project.id).max(:number)
      self.number = last_invoice_number ? ((last_invoice_number + 1).to_i) : 1
    end
  end
end
