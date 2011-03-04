class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps
  referenced_in :user
  referenced_in :task
  field :date, :type => Date
  field :hours, :type => Integer
  before_create :verify_date
  private
  def verify_date
    self.date = Time.now if date.blank?
  end
end
