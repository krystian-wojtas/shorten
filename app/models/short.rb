class Short < ActiveRecord::Base
  attr_accessible  :longer, :shorter
  attr_defaults :chrome => 0, :firefox => 0, :ie => 0, :opera => 0, :other => 0, :safari => 0

  #TODO longer shorter not blank
  
  validates_uniqueness_of :shorter
  validates_format_of :longer, :with => URI::regexp(['http'])
end
