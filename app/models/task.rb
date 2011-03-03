class Task
  include Mongoid::Document
  referenced_in :user
  referenced_in :project
  references_many :time_entries
  field :name
  def hours
    total_hours = 0
    time_entries.collect { |entry| total_hours += entry.hours }
    total_hours
  end
end
