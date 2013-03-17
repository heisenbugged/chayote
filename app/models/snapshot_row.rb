class SnapshotRow
	include Mongoid::Document

  field :total_hours, :type => BigDecimal
  field :rate, :type => BigDecimal

  referenced_in :user
	embedded_in :snapshot

end