class Stat < ActiveRecord::Base
  belongs_to :short
  attr_defaults :chrome => 0, :firefox => 0, :ie => 0, :opera => 0, :other => 0, :safari => 0

  def up(ua)
    browser = Browser.new(:ua => ua)
    
    if browser.firefox?
      Stat.increment_counter :firefox, id
    elsif browser.chrome?
      Stat.increment_counter :chrome, id
    elsif browser.ie?
      Stat.increment_counter :ie, id
    elsif browser.opera?
      Stat.increment_counter :opera, id
    elsif browser.safari?
      Stat.increment_counter :safari, id
    elsif browser.other?
      Stat.increment_counter :other, id
    end
  end
end
