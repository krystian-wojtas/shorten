class Short < ActiveRecord::Base
  attr_accessible  :longer, :shorter
  has_one :stat, :dependent => :destroy
  after_create :create_stat

  scope :busy, lambda { |short| where('shorter = ?', short).limit(1) }

  def f
    self.longer.hash + rand.hash
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

  before_validation :try_get_short, :if => lambda { |short| self.shorter.blank? }

  validates :shorter, :presence => true, :uniqueness => true
  validates :longer, :presence => true
  validates_format_of :longer, :with => URI::regexp(['http'])
end
