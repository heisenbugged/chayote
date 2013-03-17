class Snapshot
  include Mongoid::Document

  referenced_in :project
  embeds_many :snapshot_rows

  field :start_date, :type => Date
  field :end_date, :type => Date


  def self.create_from_invoice grouped_entries, start_date, end_date
  	s = Snapshot.new :start_date => start_date, :end_date => end_date
  	grouped_entries.each do |id, user_mapping|
  	  row = s.snapshot_rows.build
  	  row.total_hours = user_mapping.total_hours
  	  row.rate = user_mapping.rate
  	  row.user = user_mapping.user
  	end
  	s.save
  end

end