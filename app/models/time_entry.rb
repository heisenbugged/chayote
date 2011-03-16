class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps
  referenced_in :user
  referenced_in :task
  field :date, :type => Date
  field :hours, :type => BigDecimal
  
  validates_numericality_of :hours, :greater_than => 0

  before_create :verify_date
  private
  def verify_date
    self.date = Time.now if date.blank?
  end
end
