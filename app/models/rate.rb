class Rate
  include Mongoid::Document
  field :amount, :type => BigDecimal
end