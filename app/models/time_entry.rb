class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps
  referenced_in :user
  referenced_in :task  
  field :hours, :type => Integer
end
