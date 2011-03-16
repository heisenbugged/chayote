class Rate
  include Mongoid::Document
  field :amount, :type => BigDecimal
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than => 0
end