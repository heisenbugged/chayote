class Rate
  include Mongoid::Document
  field :amount
  referenced_in :user
end