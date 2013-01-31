class Short < ActiveRecord::Base
  attr_accessible  :longer, :shorter
  attr_defaults :chrome => 0, :firefox => 0, :ie => 0, :opera => 0, :other => 0, :safari => 0

  scope :busy, lambda { |short| where('shorter = ?', short).limit(1) }
  
  before_validation do |short|
    begin
      self.shorter = longer.hash + rand.hash
    end until(Short.busy(self.shorter).empty?)
  end

  validates :shorter, :presence => true, :uniqueness => true
  validates :longer, :presence => true
  validates_format_of :longer, :with => URI::regexp(['http'])
end
