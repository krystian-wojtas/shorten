class Short < ActiveRecord::Base
  attr_accessible  :longer, :shorter
  attr_defaults :chrome => 0, :firefox => 0, :ie => 0, :opera => 0, :other => 0, :safari => 0

  scope :busy, lambda { |short| where('shorter = ?', short).limit(1) }

  def f
    self.longer.hash.to_i + rand.to_i
  end

  def next_short
    self.shorter = f()
    ! Short.busy(self.shorter).empty?
  end
  
  def try_get_short
    i = 0
    until(!next_short or i>=10)
      i += 1
    end
  end

  before_validation do |short|
    try_get_short
  end

  validates :shorter, :presence => true, :uniqueness => true
  validates :longer, :presence => true
  validates_format_of :longer, :with => URI::regexp(['http'])
end
