require 'spec_helper'

describe Invoice do
  should_validate_presence_of :start_date, :end_date
  should_validate_numericality_of :number, :only_integer => true
  
  it "saves default fabricator projects" do
    project = Fabricate.build(:project)
    lambda { project.save }.should_not raise_error
  end
  it "generates a unique number" do
    project = Fabricate(:project)
    invoices = (1..200).collect{Invoice.create!(:start_date => Time.now, :end_date => Time.now, :project => project)}
    invoices.map{|d| d.number}.uniq!.should be_nil
  end
end
